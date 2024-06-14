import 'package:flutter/material.dart';
import 'package:music_app/pages/Settings.dart';

class Mydrawer extends StatefulWidget {
  const Mydrawer({super.key});

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          //logo
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.music_note,
                size: 45,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          // home title
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                "H O M E  ",
                textAlign: TextAlign.center,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          //settings tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 15),
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(
                "S E T T I N G S ",
                textAlign: TextAlign.center,
              ),
              onTap: () {
                // pop the drawer
                Navigator.of(context).pop();

                //navigate to the settings page
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
          )
        ],
      ),
    );
  }
}
