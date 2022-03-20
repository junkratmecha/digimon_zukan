import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings.dart';
import 'digimon_list.dart';
import 'models/theme_mode.dart';
import 'models/pokemon.dart';
import 'models/digimon.dart';
import 'models/favorite.dart';
import 'models/favoritedigi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final themeModeNotifier = ThemeModeNotifier(pref);
  final pokemonsNotifier = PokemonsNotifier();
  final digimonsNotifier = DigimonsNotifier();
  final favoritesNotifier = FavoritesNotifier();
  final favoritesDigiNotifier = FavoritesDigiNotifier();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeModeNotifier>(
          create: (context) => themeModeNotifier,
        ),
        ChangeNotifierProvider<PokemonsNotifier>(
          create: (context) => pokemonsNotifier,
        ),
        ChangeNotifierProvider<DigimonsNotifier>(
          create: (context) => digimonsNotifier,
        ),
        ChangeNotifierProvider<FavoritesNotifier>(
          create: (context) => favoritesNotifier,
        ),
        ChangeNotifierProvider<FavoritesDigiNotifier>(
          create: (context) => favoritesDigiNotifier,
        ),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeNotifier>(
      builder: (context, mode, child) => MaterialApp(
        title: 'Digimon Flutter',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: mode.mode,
        home: const TopPage(),
      ),
    );
  }
}

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  int currentbnb = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          children: const [
            // PokeList(),
            DigimonList(),
            Settings()],
          index: currentbnb,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => {
          setState(
                () => currentbnb = index,
          )
        },
        currentIndex: currentbnb,
        items: const [
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.list),
          //   label: 'home',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sd_card_outlined),
            label: 'digimons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
      ),
    );
  }
}