import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_online_shopping/src/features/home/screens/main_page.dart';
import 'package:simple_online_shopping/src/features/home/services/home_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Online Shopping',
        theme: ThemeData(
          fontFamily: GoogleFonts.notoSansThai().fontFamily,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 32),
            headlineMedium: TextStyle(fontSize: 28),
            titleLarge: TextStyle(fontSize: 22),
            titleMedium: TextStyle(fontSize: 16),
            bodyLarge: TextStyle(fontSize: 16),
            bodyMedium: TextStyle(fontSize: 14),
            bodySmall: TextStyle(fontSize: 12),
          ),
        ),
        home: const MainPage(),
        // home: MyHomePage(
        //   title: 'a',
        // ),
      ),
    );
  }
}
