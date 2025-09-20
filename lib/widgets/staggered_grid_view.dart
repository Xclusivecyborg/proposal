import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_proposal/core/extension/string_extension.dart';
import 'package:my_proposal/the_super_woman/zoomed_image.dart';
import 'package:my_proposal/widgets/proposal_video_thumbnail.dart';

class StaggeredGridView extends StatefulWidget {
  const StaggeredGridView({super.key, required this.images, this.itemBuilder});
  final List<String> images;
  final Widget Function(BuildContext context, int index, String image)?
      itemBuilder;

  @override
  State<StaggeredGridView> createState() => _StaggeredGridViewState();
}

class _StaggeredGridViewState extends State<StaggeredGridView>
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
    return MasonryGridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      itemCount: widget.images.length,
      itemBuilder: (context, index) {
        final imageUrl = widget.images[index];

        double height = (index % 10 + 1) * 185;

        final childWidget =
            widget.itemBuilder?.call(context, index, imageUrl) ??
                Container(
                  height: height > 300 ? 300.h : height.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey,
                  ),
                  child: imageUrl.containsVideoExtension
                      ? Player(
                          videoUrl: imageUrl,
                          key: ValueKey(imageUrl),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                );

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
                  child: GestureDetector(
                      onTap: () {
                        if (!imageUrl.containsVideoExtension) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ZoomedImage(
                                  imageUrl: imageUrl, type: ImageType.network),
                            ),
                          );
                        }
                      },
                      child: childWidget),
                ),
              );
            });
      },
    );
  }
}
