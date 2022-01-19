import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/feature/domain/enities/porson_entity.dart';

class PersonModel extends PersonEntity {
  PersonModel(
      {required id,
      required name,
      required status,
      required species,
      required type,
      required gender,
      required origin,
      required location,
      required image,
      required episode,
      required created})
      : super(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: origin,
            location: location,
            image: image,
            episode: episode,
            created: created);

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      origin: json['origin']['name'],
      location: json['location']['name'],
      image: json['image'],
      episode:
          (json['episode'] as List<dynamic>).map((e) => e as List).toList(),
      created: DateTime.parse(json['created'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin,
      'location': location,
      'image': image,
      'episode': episode,
      'created': created.toIso8601String(),
    };
  }
}
