import 'package:digimon_zukan/const/digimonapi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'models/digimon.dart';
import 'dart:convert';

import 'models/favoritedigi.dart';

class DigimonDetail extends StatelessWidget {
  const DigimonDetail({Key? key, required this.digi}) : super(key: key);
  final Digimon digi;
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesDigiNotifier>(
      builder: (context, favs, child) => Scaffold(
      body: Container(
        color: (digimonLevelColors[utf8.decode(digi.level.runes.toList())] ?? Colors.grey[100])
            ?.withOpacity(.5),
        child:SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                trailing: IconButton(
                  icon: favs.isExist(digi.id)
                      ? const Icon(Icons.star, color: Colors.orangeAccent)
                      : const Icon(Icons.star_outline),
                  onPressed: () => {
                    favs.toggle(FavoriteDigi(digiId: digi.id)),
                  },
                ),
              ),
              const SizedBox(height: 16),
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: Hero(
                      tag: digi.name,
                      child: CachedNetworkImage(
                        imageUrl: digi.imageUrl,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'No.${digi.id}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: Colors.white.withOpacity(.5),
                ),
                child: Text(
                  utf8.decode(digi.type.runes.toList()),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Text(
                utf8.decode(digi.name.runes.toList()),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Chip(
                backgroundColor: digimonLevelColors[utf8.decode(digi.level.runes.toList())] ?? Colors.grey,
                label: Text(
                  utf8.decode(digi.level.runes.toList()
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                child:Text(
                  utf8.decode(digi.profile.runes.toList()),
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}