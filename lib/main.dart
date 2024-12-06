import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpods_learning/bottom_navigation.dart';
import 'package:riverpods_learning/move_list.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp())) ;
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:BottomNav(),
    );
  }
}

