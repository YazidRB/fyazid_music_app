import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/themes/them_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back_ios)),
          title: const Text(
            'S E T T I N G S ',
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Consumer<ThemProvider>(
            builder: (context, value, child) => Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "D A R K   M O D E ",
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CupertinoSwitch(
                      value: value.isDark,
                      onChanged: (val) {
                        value.toggleTheme();
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
