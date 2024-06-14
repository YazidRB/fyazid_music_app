import 'package:flutter/material.dart';
import 'package:music_app/components/neu_box.dart';
import 'package:music_app/models/playList.dart';
import 'package:music_app/pages/SongPage.dart';
import 'package:music_app/themes/them_provider.dart';
import 'package:provider/provider.dart';

class Playlistpage extends StatefulWidget {
  const Playlistpage({super.key});

  @override
  State<Playlistpage> createState() => _PlaylistpageState();
}

class _PlaylistpageState extends State<Playlistpage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Playlist>(builder: (context, value, child) {
      final playlist = value.playlist;
      return ListView.builder(
        itemCount: playlist.length,
        itemBuilder: (context, index) => NeuBox(
          isDark: Provider.of<ThemProvider>(context).isDark,
          child: ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(playlist[index].imagePath)),
              title: Text(playlist[index].title),
              subtitle: Text(playlist[index].artist),
              onTap: () {
                value.currentSong = index;
                value.playMusic();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Songpage(),
                ));
              }),
        ),
      );
    });
  }
}
