import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerProvider extends ChangeNotifier {
  late FlickManager flickManager;

  void initializeVideo() async {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(
            "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
      ),
    );
    notifyListeners();
  }
}
