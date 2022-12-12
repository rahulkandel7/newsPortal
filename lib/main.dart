import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sanchar_dainek/features/bookmark/data/models/bookmark.dart';

import 'package:sanchar_dainek/features/home/presentation/screens/homepage.dart';

import '../screens/about_screen.dart';
import 'features/bookmark/presentation/screens/bookmark_screen.dart';
import 'features/home/presentation/screens/news_show.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BookmarkAdapter());
  await Hive.openBox<Bookmark>('bookmarks');
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanchar Dainik',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        textTheme: TextTheme(
          bodyText1: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          bodyText2: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          headline1: TextStyle(
            color: const Color.fromRGBO(34, 45, 102, 1),
            fontSize: Platform.isAndroid ? 26 : 20,
            fontWeight: FontWeight.w700,
          ),
          headline2: const TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.w300,
          ),
          headline4: const TextStyle(
            color: Color.fromRGBO(34, 45, 102, 1),
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
          headline5: const TextStyle(
            fontSize: 14,
            color: Colors.red,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        shadowColor: Colors.grey.shade100,
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(
          bodyText1: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          bodyText2: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          headline1: TextStyle(
            color: Colors.white,
            fontSize: Platform.isAndroid ? 26 : 20,
            fontWeight: FontWeight.w700,
          ),
          headline2: const TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.w400,
          ),
          headline4: const TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
          headline5: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        HomePage.routeName: (ctx) => const HomePage(),
        NewsShow.routeName: (ctx) => NewsShow(),
        BookmarkScreen.routeName: (ctx) => const BookmarkScreen(),
        AboutScreen.routeName: (ctx) => const AboutScreen(),
      },
    );
  }
}

//Splash Screen

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
