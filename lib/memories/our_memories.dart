import 'package:flutter/material.dart';
import 'package:my_proposal/core/extension/text_theme.dart';
import 'package:my_proposal/core/services/firebase_remote_config_service.dart';
import 'package:my_proposal/widgets/staggered_grid_view.dart';

class OurMemories extends StatefulWidget {
  const OurMemories({super.key});

  @override
  State<OurMemories> createState() => _OurMemoriesState();
}

class _OurMemoriesState extends State<OurMemories> {
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
        StaggeredGridView(images: memories)
      ],
    );
  }
}
