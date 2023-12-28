import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:head_line_hub/view/home_screen.dart';
import 'package:shimmer/shimmer.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      return Navigator.pushReplacement(
        context,
        FadePageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder(
          curve: Curves.easeInOutCirc,
          tween: Tween(begin: height * 0.01, end: 40.0),
          duration: const Duration(seconds: 2),
          builder: (BuildContext context, double value, Widget? child) {
            return Shimmer.fromColors(
              direction: ShimmerDirection.ltr,

              baseColor: Colors.red,

              highlightColor: Colors.white,
              child: Text(
                'Head Lines Hub',
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                      fontSize: value,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// transition animation
class FadePageRoute extends PageRouteBuilder {
  final WidgetBuilder builder;

  FadePageRoute({required this.builder})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );
            var opacityAnimation = animation.drive(tween);
            return FadeTransition(
              opacity: opacityAnimation,
              child: const HomeScreen(),
            );
          },
        );
}
