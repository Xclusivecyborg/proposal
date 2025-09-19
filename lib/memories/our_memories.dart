import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart'
    show MasonryGridView;
import 'package:my_proposal/core/colors/app_colors.dart';
import 'package:my_proposal/core/extension/text_theme.dart';
import 'package:my_proposal/core/services/firebase_remote_config_service.dart';

class OurMemories extends StatefulWidget {
  const OurMemories({super.key});

  @override
  State<OurMemories> createState() => _OurMemoriesState();
}

class _OurMemoriesState extends State<OurMemories>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final memories = RemoteConfigService.memoriesImages;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Our Memories",
          style: context.textTheme.t20W600,
        ),
        const SizedBox(height: 20),
        MasonryGridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          itemCount: memories.length,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          itemBuilder: (context, index) {
            double height = (index) * 200;
            final imageUrl = memories[index];
            return AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(
                        (index / 15) * 0.5,
                        math.min(((index + 1) / 15) * 0.5, 1.0),
                        curve: Curves.linear,
                      ),
                    ),
                  ),
                  child: ScaleTransition(
                    scale: Tween<double>(
                      begin: 0.8,
                      end: 1.0,
                    ).animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: Interval(
                          (index / 15) * 0.5,
                          math.min(((index + 1) / 15) * 0.5, 1.0),
                          curve: Curves.easeOut,
                        ),
                      ),
                    ),
                    child: child,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.primaryColor,
                ),
                height: height > 400 ? 400 : height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    // "https://firebasestorage.googleapis.com/v0/b/spinchat-3c35b.appspot.com/o/IMG_2051.JPG?alt=media&token=23b0d4b2-c9f2-41f5-b40c-7080d6a2cd2a",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
