import 'package:flutter/material.dart';

ThemeData LightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.deepPurple,
    foregroundColor: Colors.white,
  ),
  
  textTheme: TextTheme(
    titleLarge: TextStyle(color: Colors.black26)
  ),

  tabBarTheme: TabBarTheme(
    //indicator: BoxDecoration( color: Colors.lightBlueAccent, shape: BoxShape.circle),
    //dividerColor: Colors.amber,
    indicatorColor: Colors.orange,
    labelColor: Colors.white,
    //overlayColor: MaterialStatePropertyAll(Colors.brown.shade900),
    unselectedLabelColor: Colors.white38,

  )
);
