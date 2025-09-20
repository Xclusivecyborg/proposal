import 'package:my_proposal/core/enums/app_enums.dart';

extension StringExtension on String {
  VideoExtension get videoExtension {
    if (endsWith('.mov')) return VideoExtension.mov;
    if (endsWith('.mp4')) return VideoExtension.mp4;
    if (endsWith('.mp3')) return VideoExtension.mp3;
    if (endsWith('.mkv')) return VideoExtension.mkv;
    throw Exception('Unsupported video format');
  }

  VideoExtension get videoExtensionFromFirebaseUrl {
    if (toLowerCase().contains('.mov')) return VideoExtension.mov;
    if (toLowerCase().contains('.mp4')) return VideoExtension.mp4;
    if (toLowerCase().contains('.mp3')) return VideoExtension.mp3;
    if (toLowerCase().contains('.mkv')) return VideoExtension.mkv;
    throw Exception('Unsupported video format');
  }

  bool get containsVideoExtension {
    return toLowerCase().contains('.mov') ||
        toLowerCase().contains('.mp4') ||
        toLowerCase().contains('.mp3') ||
        toLowerCase().contains('.mkv');
  }
}
