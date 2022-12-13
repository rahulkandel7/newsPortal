import 'dart:async';

import 'package:flutter/material.dart';

import '../../features/home/presentation/screens/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(
      seconds: 2,
    ),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Timer(
        const Duration(
          seconds: 3,
        ),
        () => _navigation(context),
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  _navigation(BuildContext context) =>
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              FadeTransition(
                opacity: _animation,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.36,
              ),
              Column(
                children: const [
                  Text(
                    '#MadeInNepal',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'By BITS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
