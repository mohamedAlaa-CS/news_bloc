import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_bloc/cubit/cubit.dart';
import 'package:news_bloc/cubit/states.dart';
import 'package:news_bloc/screens/home_layout.dart';
import 'package:news_bloc/Dio/dio_helper.dart';

import 'cubit/bloc_observer.dart';
import 'shared_prefrance/cach_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // var cubit = NewsCubit.get(context);
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusiness()
        ..changemode(fromShared: isDark),
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);

            return MaterialApp(
              theme: ThemeData(
                brightness: Brightness.light,
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.black),
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
                  backgroundColor: Colors.black,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: Colors.black,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20,
                ),
              ),
              themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
              home: const HomeLayout(),
            );
          }),
    );
  }
}
