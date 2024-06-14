import 'package:flutter/material.dart';
import 'package:music_app/components/myDrawer.dart';
import 'package:music_app/pages/PlayListPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("P L A Y   L I S T "),
          centerTitle: true,
        ),
        drawer: const Mydrawer(),
        body: const Playlistpage(),
      ),
    );
  }
}
