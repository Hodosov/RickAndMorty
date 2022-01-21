import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/core/platform/network_info.dart';
import 'package:rick_and_morty/feature/data/datasourses/person_local_data_sourse.dart';
import 'package:rick_and_morty/feature/data/datasourses/person_remote_data_sourse.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:rick_and_morty/feature/domain/enities/porson_entity.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/feature/domain/repositories/person_repository.dart';

class PersonRepositoryImple implements PersonRepository {
  final PersonRemoteDataSourse remoteDataSourse;
  final PersonLocalDataSoutse localDataSourse;
  final NetworkInfo networkInfo;

  PersonRepositoryImple(
      {required this.remoteDataSourse,
      required this.localDataSourse,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons(() => remoteDataSourse.getAllPersons(page));
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPersons(() {
      return remoteDataSourse.searchPerson(query);
    });
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDataSourse.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locatioonPerson = await localDataSourse.getLastPersonsFromCache();
        return Right(locatioonPerson);
      } on Cachexception {
        return Left(CacheFailure());
      }
    }
  }
}
