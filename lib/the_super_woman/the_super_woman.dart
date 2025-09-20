import 'package:flutter/material.dart';
import 'package:my_proposal/core/extension/text_theme.dart';
import 'package:my_proposal/core/services/firebase_remote_config_service.dart';
import 'package:my_proposal/widgets/staggered_grid_view.dart';

class TheSuperWoman extends StatefulWidget {
  const TheSuperWoman({super.key});

  @override
  State<TheSuperWoman> createState() => _TheSuperWomanState();
}

class _TheSuperWomanState extends State<TheSuperWoman>
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
    final memories = RemoteConfigService.theSuperWoman;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          "The Super Woman",
          style: context.textTheme.t20W600,
        ),
        const SizedBox(height: 20),
        StaggeredGridView(
          key: ValueKey('SuperWomanStaggeredGrid'),
          images: memories,
        ),
      ],
    );
  }
}
