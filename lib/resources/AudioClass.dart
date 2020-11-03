import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioClass{

  void play(String uri) async {

    final AudioCache cache = AudioCache();
    AudioPlayer player;

    player = await cache.play(uri);

  }

}