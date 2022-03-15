import 'package:flutter/material.dart';
import '../api/digimonapi.dart';

class DigimonsNotifier extends ChangeNotifier {
  final Map<int, Digimon?> _digiMap = {};

  Map<int, Digimon?> get digis => _digiMap;

  void addDigi(Digimon digi) {
    _digiMap[digi.id] = digi;
    notifyListeners();
  }

  void fetchDigi(int id) async {
    _digiMap[id] = null;
    addDigi(await fetchDigimon(id));
  }

  Digimon? byId(int id) {
    if (!_digiMap.containsKey(id)) {
      fetchDigi(id);
    }
    return _digiMap[id];
  }
}

class Digimon {
  final int id;
  final String name;
  final String url;
  final String level;
  final String type;
  final String attribute;
  // final List<String> skill;
  final String profile;
  final String imageUrl;

  Digimon({
    required this.id,
    required this.name,
    required this.url,
    required this.level,
    required this.type,
    required this.attribute,
    // required this.skill,
    required this.profile,
    required this.imageUrl,
  });

  factory Digimon.fromJson(Map<String, dynamic> json) {
    // List<String> skillToList(dynamic skill) {
    //   List<String> ret = [];
    //   for (int i = 0; i < skill.length; i++) {
    //     ret.add(skill[i]);
    //   }
    //   return ret;
    // }

    return Digimon(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      level: json['level'],
      type: json['type'],
      attribute: json['attribute'],
      // skill: skillToList(json['skill']),
      profile: json['profile'],
      imageUrl: json['image_url'],
    );
  }
}