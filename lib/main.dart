import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rest_api/screens/homepage.dart';

void main() {
  runApp(const RESTAPI());
}

class RESTAPI extends StatelessWidget {
  const RESTAPI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "The Rick And Morty",
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme()
      ),
      home: const HomePage(),
    );
  }
}
