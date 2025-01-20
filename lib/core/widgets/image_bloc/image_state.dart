
import 'dart:typed_data';

sealed class  ImageState {}

class ImageLoadingState extends ImageState {}

class ImageLoadedState extends ImageState {
  final Uint8List bytes;

  ImageLoadedState({required this.bytes});
}

class ImageErrorState extends ImageState {
  final String message;

  ImageErrorState({required this.message});
}