import 'package:flutter/material.dart';

import 'login_page.dart';

void main() {
  runApp(const TravelDestinationApp());
}

class TravelDestinationApp extends StatelessWidget {
  const TravelDestinationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Destination',

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',

        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF176B87)),
      ),

      home: const LoginPage(),
    );
  }
}
