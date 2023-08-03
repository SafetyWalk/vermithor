import 'package:flutter/material.dart';
import 'package:safewalk/constants/colors.dart';

class FinalOnboardScreen extends StatefulWidget {
  final AnimationController animationController;

  const FinalOnboardScreen({Key? key, required this.animationController})
      : super(key: key);

  @override
  _FinalOnboardScreenState createState() => _FinalOnboardScreenState();
}

class _FinalOnboardScreenState extends State<FinalOnboardScreen>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _firstHalfAnimation;
  late Animation<Offset> _secondHalfAnimation;
  late Animation<Offset> _welcomeFirstHalfAnimation;
  late Animation<Offset> _welcomeImageAnimation;

  @override
  void initState() {
    super.initState();
    _firstHalfAnimation = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    _secondHalfAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0))
        .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.8,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    _welcomeFirstHalfAnimation = Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    _welcomeImageAnimation = Tween<Offset>(begin: Offset(4, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _welcomeImageAnimation,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 350, maxHeight: 350),
                    child: Image.asset(
                      'assets/icons/ic_safewalk.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SlideTransition(
                  position: _welcomeFirstHalfAnimation,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [AppColors.primaryGradientDarkTopLeft, AppColors.primaryGradientDarkBottomRight],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds);
                    },
                    child: Text(
                      "SafeWalk",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // The color of the text within the gradient
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 64, right: 64, top: 16, bottom: 16),
                  child: Text(
                    "Your Safety Companion",
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  'Sign Up For Free',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // The color of the text within the gradient
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
