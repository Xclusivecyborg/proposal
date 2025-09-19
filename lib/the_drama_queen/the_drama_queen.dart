import 'package:flutter/material.dart';
import 'package:my_proposal/core/extension/text_theme.dart';
import 'package:my_proposal/core/services/firebase_remote_config_service.dart';
import 'package:my_proposal/widgets/proposal_video_thumbnail.dart';

class TheDramaQueen extends StatefulWidget {
  const TheDramaQueen({super.key});

  @override
  State<TheDramaQueen> createState() => _TheDramaQueenState();
}

class _TheDramaQueenState extends State<TheDramaQueen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          "The Drama Queen 👑",
          style: context.textTheme.t30W700,
        ),
        SizedBox(height: 20),
        ProposalVideoPlayer(),
      ],
    );
  }
}
