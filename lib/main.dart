import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:nasa_apod/provider/apod_provider.dart';
import 'package:nasa_apod/router.dart';
import 'package:nasa_apod/views/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApodProvider(),
      child: MaterialApp(
        onGenerateRoute: Routers.generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'NASA APOD',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.light,
        home: const HomePage(),
      ),
    );
  }
}

