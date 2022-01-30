import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/feature/domain/enities/porson_entity.dart';
import 'package:rick_and_morty/feature/presentation/pages/person_detaol_screen.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_cache_image.dart';

class SearchResult extends StatelessWidget {
  final PersonEntity personresult;
  const SearchResult({Key? key, required this.personresult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PersonDetailPage(person: personresult)));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2.0,
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: PersonCacheImage(
                width: 150,
                height: 150,
                imageUrl: personresult.image,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                personresult.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${personresult.location.name}",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
