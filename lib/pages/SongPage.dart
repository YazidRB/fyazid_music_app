import 'package:flutter/material.dart';
import 'package:music_app/components/neu_box.dart';
import 'package:music_app/models/playList.dart';
import 'package:music_app/models/song.dart';
import 'package:music_app/themes/them_provider.dart';
import 'package:provider/provider.dart';

class Songpage extends StatelessWidget {
  const Songpage({super.key});

  // format the secends to MIN : SEC
  formatDuration(double seconds) {
    // Convert the total seconds to an integer
    int totalSeconds = seconds.toInt();

    // Calculate hours, minutes, and remaining seconds
    int minutes = (totalSeconds % 3600) ~/ 60;
    int remainingSeconds = totalSeconds % 60;

    // Format the result as a string "MM:SS"
    String formattedDuration = "${minutes.toString().padLeft(2, '0')}:"
        "${remainingSeconds.toString().padLeft(2, '0')}";

    return formattedDuration;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Playlist>(builder: (context, value, child) {
      //get the song
      Song song = value.playlist[value.currentSong];

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                value.audioPlayer.stop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text(
            "M U S I C ",
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //App Bar

                const SizedBox(
                  height: 20,
                ),
                //artWork
                NeuBox(
                  isDark: Provider.of<ThemProvider>(context).isDark,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(song.imagePath)),
                      Text(
                        song.title,
                        style: const TextStyle(fontSize: 30),
                      ),
                      Text(song.artist),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // start time

                    Text(
                        "${formatDuration(value.currentDuration.inSeconds.toDouble())}"),

                    //  shuffle
                    IconButton(
                      onPressed: () => value.shuffleSong(),
                      icon: value.isShuffled
                          ? const Icon(
                              Icons.shuffle_on_outlined,
                            )
                          : const Icon(Icons.shuffle),
                    ),
                    //  repeat
                    IconButton(
                      onPressed: () async => await value.repeatSong(),
                      icon: value.isRepeating
                          ? const Icon(Icons.repeat_one_rounded)
                          : const Icon(Icons.repeat),
                    ),

                    // end time
                    Text(
                        "${formatDuration(value.completDuration.inSeconds.toDouble())}"),
                  ],
                ),

                //slide bar

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SliderTheme(
                    data: Theme.of(context)
                        .sliderTheme
                        .copyWith(thumbShape: SliderComponentShape.noThumb),
                    child: Slider(
                      max: value.completDuration.inSeconds.toDouble(),
                      min: 0,
                      value: value.currentDuration.inSeconds.toDouble(),
                      onChanged: (val) =>
                          value.seekPosition(Duration(seconds: val.toInt())),
                    ),
                  ),
                )

                //music controls
                ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //back
                    IconButton(
                        onPressed: () => value.previousSong(),
                        icon: const Icon(
                          Icons.skip_previous_rounded,
                          size: 35,
                        ))
                    //play
                    ,
                    value.isPlaying
                        ? IconButton(
                            onPressed: () async {
                              await value.pauseOrResume();
                            },
                            icon: const Icon(
                              Icons.pause_rounded,
                              size: 40,
                            ))
                        : IconButton(
                            onPressed: () async {
                              await value.pauseOrResume();
                            },
                            icon: const Icon(
                              Icons.play_arrow_rounded,
                              size: 40,
                            )),
                    //next
                    IconButton(
                        onPressed: () => value.nextSong(),
                        icon: const Icon(
                          Icons.skip_next_rounded,
                          size: 35,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
