import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/domain/enities/porson_entity.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_cache_image.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;

  const PersonDetailPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          const SizedBox(
            height: 24,
          ),
          Text(person.name,
              style: const TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
          const SizedBox(
            height: 12,
          ),
          PersonCacheImage(
            height: 260,
            width: 260,
            imageUrl: person.image,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color:
                        person.status == 'Alice' ? Colors.green : Colors.red),
              ),
              const SizedBox(width: 8),
              Text(
                person.status,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (person.type.isNotEmpty) ...buildText('Type:', person.type),
          ...buildText('Gender:', person.gender),
          ...buildText('Number of episode:', person.episode.length.toString()),
          ...buildText('Species:', person.species),
          ...buildText('Last know location:', "${person.location.name}"),
          ...buildText('Origin:', "${person.origin.name}"),
          ...buildText('Was created:', person.created.toString()),
        ]),
      ),
    );
  }

  List<Widget> buildText(String text, String value) {
    return [
      Text(
        text,
        style: const TextStyle(color: AppColors.greyColor),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(color: Colors.white),
      ),
      const SizedBox(height: 12),
    ];
  }
}
