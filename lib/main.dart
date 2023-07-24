import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_test/features/dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:sqflite_test/features/dashboard_screen/view/dashboard.dart';
import 'package:sqflite_test/features/database/local_database.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: MaterialApp(
        // Remove the debug banner
          debugShowCheckedModeBanner: false,
          title: 'SQLITE',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(

              // primary:  Colors.yellow,
              // secondary:  Colors.yellow.shade700,

              // or from RGB
              primaryContainer: Colors.green,
              primary: Colors.pinkAccent.shade100,
              secondary: Colors.orangeAccent.shade100,
              onPrimary: Colors.white,
              onSecondary: Colors.black,
              onTertiary: Colors.red,
              // onBackground: Colors.green,
            ),
          ),
          home: const DashboardScreen()),
    );
  }
}

