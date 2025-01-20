import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_ihma/client/data/datasources/local/application_modules_db_service.dart';
import 'package:my_ihma/client/data/datasources/local/brands_db_service.dart';
import 'package:my_ihma/client/data/datasources/local/countries_db_service.dart';
import 'package:my_ihma/client/data/datasources/local/regions_db_service.dart';
import 'package:my_ihma/client/data/datasources/local/type_db_service.dart';
import 'package:my_ihma/client/data/datasources/remote/account_api_service.dart';
import 'package:my_ihma/client/data/repositories/manual_repository_impl.dart';
import 'package:my_ihma/client/domain/repositories/manual_repository.dart';
import 'package:my_ihma/client/presentation/bloc/applications/applications_bloc.dart';
import 'package:my_ihma/client/presentation/bloc/filter/filter_widget_bloc.dart';
import 'package:my_ihma/client/presentation/bloc/login/register/register_bloc.dart';
import 'package:my_ihma/client/presentation/bloc/product/procuct_bloc.dart';

import '../client/data/datasources/local/token_db_service.dart';
import '../client/data/datasources/remote/manual_api_service.dart';
import '../client/data/datasources/remote/product_api_service.dart';
import '../client/data/interceptors/token_interceptor.dart';
import '../client/data/repositories/account_repository_impl.dart';
import '../client/data/repositories/product_repository_impl.dart';
import '../client/domain/repositories/account_repository.dart';
import '../client/domain/repositories/product_repository.dart';
import '../client/presentation/bloc/home/home_bloc.dart';
import '../client/presentation/bloc/market/pom_market_bloc.dart';
import '../client/presentation/bloc/theme/theme_bloc.dart';
import '../core/widgets/image_bloc/image_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingletonAsync<String>(() async {
    String accessToken = await TokenService.accessToken();
    return accessToken;
  });
  Dio dio = Dio();

  dio.interceptors.add(TokenInterceptor());
  //add duration
  dio.options.connectTimeout = Duration(seconds: 24);
  dio.options.receiveTimeout = Duration(seconds: 24);
  sl.registerLazySingleton(() => dio);

  //database
  sl.registerLazySingleton<RegionsDBService>(() => RegionsDBService());
  sl.registerLazySingleton<CountriesDBService>(() => CountriesDBService());
  sl.registerLazySingleton<BrandsDBService>(() => BrandsDBService());
  sl.registerLazySingleton<ApplicationModulesDBService>(() => ApplicationModulesDBService());
  sl.registerLazySingleton<TypeDBService>(() => TypeDBService());

  //services
  sl.registerLazySingleton<ProductApiService>(() => ProductApiService(sl()));
  sl.registerLazySingleton<ManualApiService>(() => ManualApiService(sl()));
  sl.registerLazySingleton<AccountApiService>(() => AccountApiService(sl()));

  //repositories
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl()));
  sl.registerLazySingleton<ManualRepository>(
      () => ManualRepositoryImpl(manualApiService: sl()));
  sl.registerLazySingleton<AccountRepository>(
          () => AccountRepositoryImpl(accountApiService: sl()));

  //bloc
  sl.registerFactory(() => ImageBloc());
  sl.registerFactory(() => HomeBloc());
  sl.registerFactory(() => ThemeBloc());

  sl.registerFactory(() => PomMarketBloc(sl(), sl(), sl(),sl(), sl()));
  sl.registerFactory(() => FilterWidgetBloc(sl(), sl(), sl()));
  sl.registerFactory(() => ProductBloc(sl(),));
  sl.registerFactory(() => ApplicationsBloc(sl(),sl()));
  sl.registerFactory(() => RegisterBloc(sl(),sl()));
}
