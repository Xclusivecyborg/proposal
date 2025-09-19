import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<void> initialize() async {
  try {
    await FirebaseRemoteConfig.instance.setDefaults(defaultParameters());

    await FirebaseRemoteConfig.instance.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 60),
        minimumFetchInterval: const Duration(seconds: 60),
      ),
    );
    await FirebaseRemoteConfig.instance.fetchAndActivate();
  } catch (_) {}
}

Map<String, dynamic> defaultParameters() {
  return {};
}

class RemoteConfigService {
  static final RemoteConfigService _instance = RemoteConfigService._internal();

  factory RemoteConfigService() {
    return _instance;
  }

  RemoteConfigService._internal();

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  static List<String> get memoriesImages {
    final items = _instance._remoteConfig.getString('memories_images');
    List<String> images = jsonDecode(items).cast<String>();
    return images;
  }

  static List<String> get theDramaQueen {
    final items = _instance._remoteConfig.getString('the_drama_queen');
    List<String> images = jsonDecode(items).cast<String>();
    return images;
  }

  static List<String> get theBeautyQueen {
    final items = _instance._remoteConfig.getString('the_beauty_queen');
    List<String> images = jsonDecode(items).cast<String>();
    return images;
  }
}
