import 'package:flutter/material.dart';
import 'package:my_proposal/core/extension/text_theme.dart';
import 'package:my_proposal/widgets/network_video_player.dart';
import 'package:video_player/video_player.dart';

class Player extends StatefulWidget {
  const Player({super.key, required this.videoUrl});
  final String videoUrl;

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl
          // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
          ),
    )..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.scale(
                    scale: 1.5,
                    child: VideoPlayer(
                      _controller,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(color: Colors.black54),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Tap to Play',
                        style: context.textTheme.t14W500
                            .copyWith(color: Colors.white70),
                      ),
                      IconButton(
                        iconSize: 50,
                        color: Colors.white,
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                        onPressed: () {
                          showGeneralDialog(
                            context: context,
                            pageBuilder: (context, _, __) {
                              return NetworkVideoPlayer(
                                networkImage: widget.videoUrl,
                                shouldPlay: true,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : SizedBox();
  }
}
