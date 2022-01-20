import 'dart:convert';

import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSoutse {
  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
}

const String CACHE_PERSONS_LIST = 'CACHE_PERSONS_LIST';

class PersonLocalDataSourseImpl implements PersonLocalDataSoutse {
  final SharedPreferences sharedPreferences;
  PersonLocalDataSourseImpl({required this.sharedPreferences});
  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList = sharedPreferences.getStringList(CACHE_PERSONS_LIST);
    if (jsonPersonsList!.isNotEmpty) {
      return Future.value(jsonPersonsList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw Cachexception();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((person) => json.encode(person.toJson())).toList();
    sharedPreferences.setStringList(CACHE_PERSONS_LIST, jsonPersonsList);
    return Future.value(jsonPersonsList);
  }
}
