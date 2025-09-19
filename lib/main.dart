import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_proposal/core/colors/app_colors.dart';
import 'package:my_proposal/core/extension/text_theme.dart';
import 'package:my_proposal/core/services/firebase_remote_config_service.dart'
    show initialize;
import 'package:my_proposal/firebase_options.dart';
import 'package:my_proposal/memories/our_memories.dart';
import 'package:my_proposal/the_drama_queen/the_drama_queen.dart';
import 'package:my_proposal/the_drama_queen/walk_with_me.dart';
import 'package:my_proposal/typing_animator.dart';

String story = '''
I'll never forget what caught your attention - a simple flutterwave water bottle. It's funny how the smallest things can lead to the greatest adventures. That water bottle was the start of our beautiful journey, a journey filled with laughter, love, and countless cherished memories. 

''';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 1024),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Forever and Always',
        theme: ThemeData(
          fontFamily: 'NotoSerif',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  bool text1Complete = false;
  bool text2Complete = false;
  bool text3Complete = false;
  bool text4Complete = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), //TODO: revert to 7
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isBigScreen = width > 600;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 15, top: 15),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: .2),
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'icons/star.svg',
                    height: 16.sp,
                    width: 16.sp,
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'Forever & Always ',
                    style: context.textTheme.t20W600,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return ScaleTransition(
                          scale: Tween<double>(
                            begin: 0.8,
                            end: 1.0,
                          ).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: Interval(
                                (0 / 15) * 0.9,
                                min(((0 + 1) / 5) * 0.5, 1.0),
                                curve: Curves.easeOut,
                              ),
                            ),
                          ),
                          child: SizedBox(
                            height: isBigScreen ? 600.h : 390.h,
                            width: MediaQuery.sizeOf(context).width,
                            child: Stack(
                              // clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/spinchat-3c35b.appspot.com/o/our_images%2FIMG_1415.JPG?alt=media&token=bb15b7e2-be1b-4b0f-b9fa-5fa32b29fcbc",
                                  // "https://firebasestorage.googleapis.com/v0/b/spinchat-3c35b.appspot.com/o/IMG_2051.JPG?alt=media&token=23b0d4b2-c9f2-41f5-b40c-7080d6a2cd2a",
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.white.withValues(alpha: .4),
                                        Colors.black.withValues(alpha: .4),
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      TypingAnimator(
                                        fullText: 'Forever & Always',
                                        speed: Duration(milliseconds: 20),
                                        builder: (text) => Text(
                                          text,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24.sp,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                        onComplete: () {
                                          setState(() {
                                            text1Complete = true;
                                          });
                                        },
                                      ),
                                      TypingAnimator(
                                        fullText:
                                            'All we needed was God, a gym, and a Flutterwave bottle. Lol!, this has to be the most beautiful love story ever 🥰',
                                        speed: Duration(milliseconds: 0),
                                        builder: (text) => Text(
                                          text,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                        onComplete: () {
                                          setState(() {
                                            text2Complete = true;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (text1Complete)
                            TypingAnimator(
                              fullText: "Our Story",
                              speed: Duration(milliseconds: 100),
                              builder: (text) => Text(
                                text,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.sp,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              onComplete: () {
                                setState(() {
                                  text3Complete = true;
                                });
                              },
                            ),
                          if (text3Complete)
                            TypingAnimator(
                              fullText: story,
                              speed: Duration(milliseconds: 20),
                              builder: (text) => Text(
                                text,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              onComplete: () {
                                setState(() {
                                  text4Complete = true;
                                  _animationController
                                    ..reset()
                                    ..forward();
                                });
                              },
                            ),
                          if (text4Complete) ...[
                            OurMemories(),
                            WalkWithMe(),
                            TheDramaQueen(),
                          ]
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class MyImage extends StatelessWidget {
//   const MyImage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     String imageUrl =
//         "https://firebasestorage.googleapis.com/v0/b/spinchat-3c35b.appspot.com/o/IMG_2051.JPG?alt=media&token=23b0d4b2-c9f2-41f5-b40c-7080d6a2cd2a";
//     // https://github.com/flutter/flutter/issues/41563
//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(
//       imageUrl,
//       (int _) => ImageElement()..src = imageUrl,
//     );
//     return HtmlElementView(
//       viewType: imageUrl,
//     );
//   }
// }
