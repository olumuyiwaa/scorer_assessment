import 'package:flutter/material.dart';
import 'package:match_detail_screen/active_session.dart';

void main() async {
  runApp(const MatchAssessment());
}

class MatchAssessment extends StatelessWidget {
  const MatchAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0XFFFFFFFF),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        applyElevationOverlayColor: false,
        fontFamily: 'Poppins', //global font family
      ),
      home: const ActiveSession(), // initial route
    );
  }
}
