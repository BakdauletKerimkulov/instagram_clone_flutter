import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

/*
  Запуск и управление видео происходит здесь
  Возможности:
   - Задать размер видео
 */

const int _maxRepeats = 2;

class VideoItem extends StatefulWidget {
  final String videoUrl;

  const VideoItem({super.key, required this.videoUrl});

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;

  int repeatCount = 0;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..addListener(_onVideoUpdate)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVideoUpdate() {
    if (!_controller.value.isInitialized) return;

    final position = _controller.value.position;
    final duration = _controller.value.duration;

    if (position >= duration && repeatCount < _maxRepeats) {
      repeatCount++;
      _controller.seekTo(Duration.zero);
      _controller.play();
    }
  }

  void _handleVisibilityChanged(VisibilityInfo info) {
    if (!mounted || !_controller.value.isInitialized) return;

    if (info.visibleFraction == 0.0) {
      _controller.pause();
    } else if (info.visibleFraction > 0.5) {
      _controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey(widget.videoUrl),
      onVisibilityChanged: _handleVisibilityChanged,
      child: AspectRatio(
        aspectRatio: 9 / 13,
        child: _controller.value.isInitialized
            ? buildVideoPlayer()
            : SizedBox(
                height: 400,
                width: double.infinity,
                child: Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }

  Widget buildVideoPlayer() {
    final video = AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );

    return buildVideoScreen(child: video);
  }

  Widget buildVideoScreen({required Widget child}) {
    final size = _controller.value.size;
    final width = size.width;
    final height = size.height;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}
