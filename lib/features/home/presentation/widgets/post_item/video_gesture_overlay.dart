import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoGestureOverlay extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoGestureOverlay({super.key, required this.controller});

  @override
  State<VideoGestureOverlay> createState() => _VideoGestureOverlayState();
}

class _VideoGestureOverlayState extends State<VideoGestureOverlay> {
  final bool _showPlayPauseIcon = false;
  final bool _showLikeIcon = false;

  IconData _playPauseIcon = Icons.pause;

  void _handleSingleTap() {
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
      _playPauseIcon = Icons.pause;
    } else {
      widget.controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
