import 'package:flutter/material.dart';
import 'package:ifruit_classifier/pages/home_page.dart';
import 'package:splashscreen/splashscreen.dart';


class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: HomePage(),
      title: Text(
        'Classifier Fruits',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
          color: Color(0xFF6CEB96),
        ),
      ),
      image: Image.asset('assets/healty-food.png'),
      gradientBackground: LinearGradient(
        colors: [ 
        Color(0xFFB583F0),
        Color(0xFFEB6CC1), 
        Color(0xFFFF6589)
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,

      ),
      photoSize: 50.0,
      loaderColor: Color(0xFF6CEB96), 
    );
  }
}