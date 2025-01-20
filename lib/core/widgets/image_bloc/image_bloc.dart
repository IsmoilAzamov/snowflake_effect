import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart'; // Import cache manager
import '../../../di/di.dart';
import 'image_event.dart';
import 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final CacheManager _cacheManager;
  final Dio _dio;

  ImageBloc()
      : _cacheManager = CacheManager(Config(
          "myImageCache",
          stalePeriod: const Duration(days: 7),
          maxNrOfCacheObjects: 100,
        )),
        _dio = sl<Dio>(),
        super(ImageLoadingState()) {
    on<GetImageEvent>(_getImage);
  }

  Future<void> _getImage(GetImageEvent event, Emitter<ImageState> emit) async {
    emit(ImageLoadingState());
    try {
      // Check cache first
      final cachedFile = await _cacheManager.getFileFromCache(event.url);
      if (cachedFile != null) {
        final imageData = await cachedFile.file.readAsBytes();
        emit(ImageLoadedState(bytes: imageData));
        return;
      }

      // Fetch from network
      final response = await _dio.get<List<int>>(
        event.url,
        options: Options(
          responseType: ResponseType.bytes,
          sendTimeout: Duration(seconds: 40),
          receiveTimeout: Duration(seconds: 40),
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final imageData = Uint8List.fromList(response.data!);
        await _cacheManager.putFile(event.url, imageData);
        emit(ImageLoadedState(bytes: imageData));
      } else {
        emit(ImageErrorState(message: "Failed to load image: ${response.statusCode}"));
      }
    } catch (e) {
      emit(ImageErrorState(message: e.toString()));
    }
  }
}
