import 'package:flutter/material.dart';
import 'package:my_proposal/core/colors/app_colors.dart';
import 'package:my_proposal/core/services/firebase_remote_config_service.dart';
import 'package:my_proposal/widgets/network_video_player.dart';
import 'package:my_proposal/widgets/staggered_grid_view.dart';
import 'package:video_player/video_player.dart';

class ProposalVideoPlayer extends StatefulWidget {
  const ProposalVideoPlayer({super.key});

  @override
  State<ProposalVideoPlayer> createState() => _ProposalVideoPlayerState();
}

class _ProposalVideoPlayerState extends State<ProposalVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    final videos = RemoteConfigService.theDramaQueen;
    return StaggeredGridView(
      key: ValueKey('DramaQueenStaggeredGrid'),
      images: videos,
      itemBuilder: (context, index, image) {
        double height = (index + 1) * 200;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.primaryColor,
          ),
          height: height > 300 ? 300 : height,
          child: Player(
            videoUrl: image,
            key: ValueKey(image),
          ),
        );
      },
    );
  }
}

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
                clipBehavior: Clip.antiAliasWithSaveLayer,
                children: [
                  Transform.scale(
                    scale: 2,
                    child: VideoPlayer(
                      _controller,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: IconButton(
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : SizedBox();
  }
}
