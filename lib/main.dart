import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_bloc/cubit/cubit.dart';
import 'package:news_bloc/screens/home_layout.dart';
import 'package:news_bloc/Dio/dio_helper.dart';

import 'cubit/bloc_observer.dart';

void main() {
  DioHelper.init();
  Bloc.observer = MyBlocObserver();

  runApp(BlocProvider(
      create: (BuildContext context) => NewsCubit(), child:const  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var cubit = NewsCubit.get(context);
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.red),
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
          elevation: 20,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.red),
            backgroundColor: Colors.black,
            elevation: 0,
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
          elevation: 20,
        ),
      ),
      themeMode: cubit.iconBool ? cubit.dark : cubit.light,
      home:const HomeLayout(),
    );
  }
}
