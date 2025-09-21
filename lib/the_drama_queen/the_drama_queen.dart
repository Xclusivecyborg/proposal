import 'package:flutter/material.dart';
import 'package:my_proposal/core/extension/text_theme.dart';
import 'package:my_proposal/core/services/firebase_remote_config_service.dart';
import 'package:my_proposal/widgets/staggered_grid_view.dart';

class TheDramaQueen extends StatefulWidget {
  const TheDramaQueen({super.key});

  @override
  State<TheDramaQueen> createState() => _TheDramaQueenState();
}

class _TheDramaQueenState extends State<TheDramaQueen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          "The Drama Queen 👑",
          style: context.textTheme.t20W600,
        ),
        SizedBox(height: 20),
        StaggeredGridView(
          images: RemoteConfigService.theDramaQueen,
          key: ValueKey('DramaQueenStaggeredGrid'),
        ),
      ],
    );
  }
}
