import 'package:flutter/material.dart';
import 'package:news/apps/theme_custom.dart';
import 'package:news/pages/home/home_page.dart';
import 'package:news/provider/favourite_provider.dart';
import 'package:news/provider/search_provider.dart';
import 'package:news/provider/setting_provider.dart';
import 'package:news/provider/sport_provider.dart';
import 'package:news/provider/viewed_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SettingsProvider()..init(),
        ),
        ChangeNotifierProvider(
          create: (context) => SportProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavouriteProvider()..init(),
        ),
        ChangeNotifierProvider(
          create: (context) => ViewedProvider()..init(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
            theme: ThemeCustom.lightTheme,
          );
        },
      ),
    );
  }
}
