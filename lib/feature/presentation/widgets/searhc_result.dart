import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/feature/domain/enities/porson_entity.dart';

class SearchResult extends StatelessWidget {
  final PersonEntity personresult;
  const SearchResult({Key? key, required this.personresult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2.0,
      child: Column(
        children: [
          Text(
            personresult.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
