import 'package:flutter/material.dart';
import 'package:my_proposal/core/extension/text_theme.dart';
import 'package:my_proposal/core/services/firebase_remote_config_service.dart';
import 'package:my_proposal/widgets/staggered_grid_view.dart';

class TheBeautyQueen extends StatefulWidget {
  const TheBeautyQueen({super.key});

  @override
  State<TheBeautyQueen> createState() => _TheBeautyQueenState();
}

class _TheBeautyQueenState extends State<TheBeautyQueen>
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
    final memories = RemoteConfigService.theBeautyQueen;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          "The Beauty Queen",
          style: context.textTheme.t20W600,
        ),
        const SizedBox(height: 20),
        StaggeredGridView(
          images: memories,
          key: ValueKey('BeautyQueenStaggeredGrid'),
        ),
      ],
    );
  }
}
