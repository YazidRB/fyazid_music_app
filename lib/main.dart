import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/models/playList.dart';
import 'package:music_app/pages/myHomePage.dart';
import 'package:music_app/themes/them_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => Playlist(),
      )
    ],
    builder: (context, child) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemProvider>(
      builder: (context, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: value.themeData,
          home: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: value.isDark
                  ? const Color.fromRGBO(
                      21, 21, 21, 21) // Change the status bar color
                  : Colors.white,
              statusBarIconBrightness: value.isDark
                  ? Brightness.light
                  : Brightness.dark, // Change the status bar icon color
            ),
            child: const MyHomePage(),
          )),
    );
  }
}
