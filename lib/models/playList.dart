import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/song.dart';

class Playlist with ChangeNotifier {
  // list of songs by default
  final List<Song> _playlist = [
    Song(
        title: "SO Cool",
        artist: "Zed K",
        imagePath: "assets/images/song1.jpg",
        songPath: "audio/aatrox-the-enemy.mp3"),
    Song(
        title: "Really",
        artist: "Phobia",
        imagePath: "assets/images/song2.jpg",
        songPath: "audio/aatrox-become-the-world-ender.mp3"),
    Song(
        title: "ALLAH",
        artist: "Maher",
        imagePath: "assets/images/song3.jpg",
        songPath: "audio/aatrox-i-must-congratulate-you.mp3"),
  ];

  // List of songs getter
  List<Song> get playlist => _playlist;

  // current song index 'first one by default'
  int _currentSong = 0;
  int get currentSong => _currentSong;

  // current Song setter
  set currentSong(int index) {
    _currentSong = index;
    notifyListeners();
  }

  // audio player init
  AudioPlayer audioPlayer = AudioPlayer();

  // durations variables
  Duration currentDuration = Duration.zero;
  Duration completDuration = Duration.zero;

  // initialisation if not playing by default
  bool isPlaying = false;
  bool isRepeating = false;
  bool isShuffled = false;

  Playlist() {
    //start listning to durations in the class start
    setDurations();
  }

  // play the current song
  void playMusic() async {
    await audioPlayer.play(AssetSource(playlist[currentSong].songPath));
    isPlaying = true;
    notifyListeners();
  }

  // pasue the song
  pauseMusic() async {
    await audioPlayer.pause();
    isPlaying = false;
    notifyListeners();
  }

  // resume the song
  resumeMusic() async {
    await audioPlayer.resume();
    isPlaying = true;
    notifyListeners();
  }

  //stop Song
  stopSong() async {
    await audioPlayer.stop();
    isPlaying = false;
    notifyListeners();
  }

  // pause or resume
  pauseOrResume() {
    isPlaying ? pauseMusic() : playMusic();
  }

  // seek to a position
  seekPosition(Duration newDuration) async {
    if (!isPlaying) playMusic();

    await audioPlayer.seek(newDuration);

    notifyListeners();
  }

  // set duraion informations
  setDurations() async {
    // get the complete duration
    await audioPlayer.onDurationChanged.listen((Duration d) {
      completDuration = d;
      notifyListeners();
    });

    // get the current duration
    audioPlayer.onPositionChanged.listen((Duration p) {
      currentDuration = p;
      notifyListeners();
    });

    // change the bool if song is completed
    audioPlayer.onPlayerComplete.listen((_) {
      isPlaying = false;
      nextSong();
      notifyListeners();
    });
  }

  // repeat function
  repeatSong() async {
    if (!isRepeating) {
      await audioPlayer.setReleaseMode(ReleaseMode.loop);
      isRepeating = true;
    } else {
      await audioPlayer.setReleaseMode(ReleaseMode.stop);
      isRepeating = false;
    }
    notifyListeners();
  }

  // shuffle function
  shuffleSong() {
    isShuffled = !isShuffled;
    notifyListeners();
  }

  // play next song
  nextSong() {
    stopSong();
    int oldsong = currentSong;

    // if the next song with shuffling mode
    if (isShuffled) {
      // chose a random song
      currentSong = Random().nextInt(playlist.length);
      // if the random song is the same old song then go to the next song
      if (currentSong == oldsong) nextSong();
    } else {
      // move to the next song
      currentSong = (currentSong + 1) % playlist.length;
    }
    playMusic();
    notifyListeners();
  }

  // play previous song
  previousSong() async {
    // if the duration is < 2 secends
    if (currentDuration <= const Duration(seconds: 2)) {
      stopSong();
      currentSong = (currentSong - 1) % playlist.length;
      playMusic();
      notifyListeners();
    }
    // if the duration is > 2 secends then repeat the song
    else {
      // stop the music and play it again from the begining
      await stopSong();
      playMusic();
    }
  }

  // dispose audio player
  @override
  void dispose() {
    //dispose the audio player instence
    audioPlayer.dispose();
    super.dispose();
  }
}
