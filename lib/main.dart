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
import 'package:my_proposal/the_beauty_queen/the_beauty_queen.dart';
import 'package:my_proposal/the_drama_queen/the_drama_queen.dart';
import 'package:my_proposal/the_drama_queen/walk_with_me.dart';
import 'package:my_proposal/the_super_woman/the_super_woman.dart';
import 'package:my_proposal/typing_animator.dart';
import 'package:my_proposal/widgets/before_we_proceed.dart';
import 'package:my_proposal/widgets/ending_text.dart';
import 'package:my_proposal/widgets/header_display.dart';

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
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Forever and Always',
          theme: ThemeData(
            fontFamily: 'NotoSerif',
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool text1Complete = false;
  bool text2Complete = false;
  bool text3Complete = false;
  bool text4Complete = false;
  bool questionAnswered = false;

  @override
  Widget build(BuildContext context) {
    final widgets = [
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
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderDisplay(
            onOneComplete: () {
              setState(() {
                text1Complete = true;
              });
            },
            onTwoComplete: () {
              setState(() {
                text2Complete = true;
              });
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
                        fontSize: 14.sp,
                      ),
                    ),
                    onComplete: () {
                      setState(() {
                        text4Complete = true;
                      });
                    },
                  ),
                if (text4Complete) ...[
                  OurMemories(),
                  SizedBox(height: 50),
                  WhoIsGummyBear(),
                  if (!questionAnswered) ...[
                    WalkWithMe(),
                    BeforeWeProceed(
                      onAnswer: (bool answer) {
                        setState(() {
                          questionAnswered = true;
                        });
                      },
                    ),
                  ],
                  if (questionAnswered) ...[
                    FutureBuilder(
                      future: Future.delayed(
                        const Duration(
                          seconds: 3,
                        ),
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Center(
                            child: Column(
                              children: [
                                TheDramaQueen(),
                                TheBeautyQueen(),
                                TheSuperWoman(),
                                SizedBox(height: 50),
                                EndingText(),
                              ],
                            ),
                          );
                        }
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: Text(
                              "Yay!! Loading more surprises... ",
                              style: context.textTheme.t20W600,
                            ),
                          ),
                        );
                      },
                    ),
                  ]
                ]
              ],
            ),
          ),
        ],
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF531d2d),
                Color(0xFF3f1c30),
                Color(0xFF161e3d),
              ],
            ),
          ),
          child: Stack(
            children: [
              ListView.builder(
                itemBuilder: (context, index) {
                  return widgets[index];
                },
                itemCount: widgets.length,
              ),
              // if (questionAnswered)
              //   Positioned.fill(
              //     child: TweenAnimationBuilder(
              //       tween: StepTween(begin: 0, end: 1),
              //       duration: const Duration(milliseconds: 3000),
              //       builder: (context, val, __) {
              //         return Visibility(
              //           visible: val < 1,
              //           child: RiveAnimation.asset(
              //             'assets/rive/welcome_animation.riv',
              //             fit: BoxFit.cover,
              //           ),
              //         );
              //       },
              //     ),
              //   ),
            ],
          ),
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
