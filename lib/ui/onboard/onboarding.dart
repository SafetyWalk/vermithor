import 'package:safewalk/ui/onboard/components/center_next_button.dart';
import 'package:safewalk/ui/onboard/components/second_view.dart';
import 'package:safewalk/ui/onboard/components/splash_view.dart';
import 'package:safewalk/ui/onboard/components/top_back_skip_view.dart';
import 'package:safewalk/ui/onboard/components/final_onboard.dart';
import 'package:flutter/material.dart';
import 'package:safewalk/utils/routes/routes.dart';

class OnboardingAnimationScreen extends StatefulWidget {
  const OnboardingAnimationScreen({Key? key}) : super(key: key);

  @override
  _OnboardingAnimationScreenState createState() =>
      _OnboardingAnimationScreenState();
}

class _OnboardingAnimationScreenState
    extends State<OnboardingAnimationScreen> with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 8));
    _animationController?.animateTo(0.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_animationController?.value);
    return Scaffold(
      // backgroundColor: Color(0xffF7EBE1),
      body: ClipRect(
        child: Stack(
          children: [
            SplashView(
              animationController: _animationController!,
            ),
            SecondView(
              animationController: _animationController!,
            ),
            FinalOnboardScreen(
              animationController: _animationController!,
            ),
            TopBackSkipView(
              onBackClick: _onBackClick,
              // onSkipClick: _onSkipClick,
              animationController: _animationController!,
            ),
            CenterNextButton(
              animationController: _animationController!,
              onNextClick: _onNextClick,
            ),
          ],
        ),
      ),
    );
  }

  // void _onSkipClick() {
  //   _animationController?.animateTo(0.8,
  //       duration: Duration(milliseconds: 1200));
  // }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.8 &&
        _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _signUpClick();
    }
  }

  void _signUpClick() {
    Navigator.pushNamed(context, Routes.login);
  }
}
