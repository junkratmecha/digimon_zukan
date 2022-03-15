import 'package:digimon_book/const/digimonapi.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'digimon_detail.dart';
import 'models/digimon.dart';
import 'dart:convert';
import 'const/digimonapi.dart';

class DigimonListItem extends StatelessWidget {
  const DigimonListItem({Key? key, required this.digi}) : super(key: key);
  final Digimon? digi;
  @override
  Widget build(BuildContext context) {
    if (digi != null) {
      return ListTile(
        leading: Container(
          width: 80,
          decoration: BoxDecoration(
            color: (digimonLevelColors[utf8.decode(digi!.level.runes.toList())] ?? Colors.grey[100])
                ?.withOpacity(.3),
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: CachedNetworkImageProvider(
                digi!.imageUrl,
              ),
            ),
          ),
        ),
        title: Text(
          utf8.decode(digi!.name.runes.toList()),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text(digi!.skill.join(', ')),
        trailing: const Icon(Icons.navigate_next),
        onTap: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => DigimonDetail(digi: digi!),
            ),
          ),
        },
      );
    } else {
      return const ListTile(title: Text('...'));
    }
  }
}