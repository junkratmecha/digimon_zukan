import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digimon_zukan/const/digimonapi.dart';
import 'package:flutter/material.dart';
import 'digimon_detail.dart';
import 'models/digimon.dart';
import 'const/digimonapi.dart';

class DigimonGridItem extends StatelessWidget {
  const DigimonGridItem({Key? key, required this.digi}) : super(key: key);
  final Digimon? digi;
  @override
  Widget build(BuildContext context) {
    if (digi != null) {
      return Column(
        children: [
          InkWell(
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => DigimonDetail(digi: digi!),
                ),
              ),
            },
            child: Container(
              height: 100,
              width: 100,
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
          ),
          Text(
            utf8.decode(digi!.name.runes.toList()),
            style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
          ),
        ],
      );
    } else {
      return const SizedBox(
        height: 100,
        width: 100,
        child: Center(
          child: Text('...'),
        ),
      );
    }
  }
}