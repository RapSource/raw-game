import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../widgets/bottom_tabbar.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/splash_page';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () async {
      await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomTapBar()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.black87, Colors.blueAccent])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
              width: 250,
              child: LottieBuilder.asset(
                'assets/animations/75126-gaming-console.json',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Game',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontSize: 20,
                    )),
                const SizedBox(width: 3),
                AnimatedTextKit(
                  animatedTexts: [
                    RotateAnimatedText('R',
                        textStyle: const TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 25,
                            fontWeight: FontWeight.bold))
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  pause: const Duration(milliseconds: 50),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
