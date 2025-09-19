import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class NetworkVideoPlayer extends StatefulWidget {
  const NetworkVideoPlayer({
    super.key,
    required this.networkImage,
    required this.shouldPlay,
  });
  final String networkImage;
  final bool shouldPlay;

  @override
  State<NetworkVideoPlayer> createState() => _NetworkVideoPlayerState();
}

class _NetworkVideoPlayerState extends State<NetworkVideoPlayer> {
  VideoPlayerController? _controller;
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    _initializePlayer();
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   _play();
    // });
  }

  void _initializePlayer() {
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.networkImage))
          ..initialize().then((value) => setStateIfMounted(() {
                _play();
              }))
          ..addListener(() async {
            if (_controller != null) {
              final position = _controller?.value.position;
              final duration = _controller?.value.duration.inSeconds;
              if (duration == position?.inSeconds) {
                log('Ended video playing');
                if (mounted) {
                  setStateIfMounted(() {
                    isPlaying = false;
                  });
                }
              }
            }
          });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void setStateIfMounted(void Function() callBack) {
    if (mounted) setState(callBack);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _play,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            if ((_controller?.value.size.aspectRatio ?? 0) > 0)
              Align(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: _controller?.value.size.aspectRatio ?? .8,
                  child: VideoPlayer(_controller!),
                ),
              ),
            Visibility(
              visible: !isPlaying,
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: _play,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _play() {
    if (widget.shouldPlay) {
      if (isPlaying) {
        isPlaying = false;
        setStateIfMounted(() {});
        _controller?.pause();
      } else {
        isPlaying = true;
        setStateIfMounted(() {});
        _controller?.play();
      }
    }
  }
}
