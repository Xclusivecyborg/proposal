import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ZoomedImage extends StatefulWidget {
  const ZoomedImage({
    super.key,
    required this.imageUrl,
    required this.type,
  });
  final String imageUrl;
  final ImageType type;
  @override
  State<ZoomedImage> createState() => _ZoomedImageState();
}

class _ZoomedImageState extends State<ZoomedImage>
    with SingleTickerProviderStateMixin {
  late TransformationController _controller;
  late AnimationController _animationController;
  late Animation<Matrix4> _animation;

  @override
  void initState() {
    super.initState();
    _controller = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        _controller.value = _animation.value;
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _resetAnimation() {
    _animation = Matrix4Tween(
      begin: _controller.value,
      end: Matrix4.identity(),
    ).animate(_animationController);
    _animationController.forward(from: 0);
  }

  Widget _buildImage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          int sensitivity = 10;
          if (details.delta.dy > sensitivity ||
              details.delta.dy < -sensitivity) {
            Navigator.of(context).pop();
          }
        },
        child: InteractiveViewer(
          onInteractionEnd: (details) {
            _resetAnimation();
          },
          transformationController: _controller,
          clipBehavior: Clip.none,
          minScale: 1,
          maxScale: 4,
          panEnabled: false,
          child: widget.type == ImageType.file
              ? Image.asset(widget.imageUrl, fit: BoxFit.contain)
              : CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.contain,
                  progressIndicatorBuilder: (context, url, progress) =>
                      CircularProgressIndicator(
                    value: progress.progress,
                  ),
                  errorWidget: (context, url, error) {
                    return const Center(
                      child: Text(
                        'An error occurred while Loading the image..',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildImage();
  }
}

enum ImageType {
  network,
  file,
}
