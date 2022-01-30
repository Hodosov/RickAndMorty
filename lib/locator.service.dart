import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morty/core/platform/network_info.dart';
import 'package:rick_and_morty/feature/data/datasourses/person_local_data_sourse.dart';
import 'package:rick_and_morty/feature/data/datasourses/person_remote_data_sourse.dart';
import 'package:rick_and_morty/feature/data/repositories/person_repository_imple.dart';
import 'package:rick_and_morty/feature/domain/repositories/person_repository.dart';
import 'package:rick_and_morty/feature/domain/usecases/get_all_persons.dart';
import 'package:rick_and_morty/feature/domain/usecases/search_person.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc / Cubit
  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));
  sl.registerFactory(() => PersonSearchBloc(searchPerson: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllPersons(sl()));
  sl.registerLazySingleton(() => SearchPerson(sl()));

  //Repository
  sl.registerLazySingleton<PersonRepository>(() => PersonRepositoryImple(
      remoteDataSourse: sl(), localDataSourse: sl(), networkInfo: sl()));
  sl.registerLazySingleton<PersonRemoteDataSourse>(
      () => PersonRemoteDataSourceImpl(client: http.Client()));
  sl.registerLazySingleton<PersonLocalDataSourse>(
      () => PersonLocalDataSourseImpl(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImple(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
