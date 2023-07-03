import 'package:flutter/material.dart';
import 'package:news_bloc/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_bloc/screens/science/science_screen.dart';
import 'package:news_bloc/screens/sports/sports_screen.dart';
import '../Dio/dio_helper.dart';
import '../screens/business/business_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItem =const [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'science'),

  ];

  List<Widget> screens =const [BusinessScreen(), SportsScreen(), ScienceScreen(),];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1){getSports();}
    if (index == 2){getScience();}
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

 void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'sa',
        'category': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
      },
    ).then((value) {
      // print(value.data['articles'][0]['title']);

      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetDataBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports =[];

 void getSports() {
   emit(NewsGetSportsLoadingState());
   if (sports.length == 0) {
     DioHelper.getData(url: 'v2/top-headlines', query: {
       'country': 'sa',
       'category': 'sports',
       'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
     },).then((value) {
       sports = value.data['articles'];
       print(sports[0]['title']);
       emit(NewsGetSportsSuccessState());
     }).catchError((error) {
       print(error.toString());
       emit(NewsGetDataSportsErrorState(error.toString()));
     });
   }else{
     emit(NewsGetSportsSuccessState());

   }
 }

  List<dynamic> science =[];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'sa',
        'category': 'science',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
      },).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetDataScienceErrorState(error.toString()));
      });
    }else{        emit(NewsGetScienceSuccessState());
    }
  }


  bool iconBool = true;


  IconData iconLight = Icons.wb_sunny;
  IconData iconDark = Icons.nights_stay;

  var light = ThemeMode.light;
  var dark = ThemeMode.dark;


  changeIconMode(){
//  if  (iconBool==false){
//
// //  ThemeData lightMode = ThemeData(
// //   primarySwatch: Colors.deepOrange,
// //   scaffoldBackgroundColor: Colors.white,
// //   appBarTheme: const AppBarTheme(
// //       iconTheme: IconThemeData(color: Colors.black),
// //       systemOverlayStyle:
// //       SystemUiOverlayStyle(statusBarColor: Colors.red),
// //       backgroundColor: Colors.white,
// //       elevation: 0,
// //       titleTextStyle: TextStyle(
// //           color: Colors.black,
// //           fontSize: 24,
// //           fontWeight: FontWeight.bold)),
// //   bottomNavigationBarTheme:const BottomNavigationBarThemeData(
// //     type: BottomNavigationBarType.fixed,
// //     selectedItemColor: Colors.deepOrange,
// //     elevation: 20,
// //   ),
// // );
//    iconBool = true;
//  }
//  else if  (iconBool==true){
//    // ThemeData darkMode = ThemeData(
//    //   primarySwatch: Colors.deepOrange,
//    //   scaffoldBackgroundColor: Colors.grey,
//    //   appBarTheme: const AppBarTheme(
//    //       iconTheme: IconThemeData(color: Colors.white),
//    //       systemOverlayStyle:
//    //       SystemUiOverlayStyle(statusBarColor: Colors.red),
//    //       backgroundColor: Colors.grey,
//    //       elevation: 0,
//    //       titleTextStyle: TextStyle(
//    //           color: Colors.white,
//    //           fontSize: 24,
//    //           fontWeight: FontWeight.bold)),
//    //   bottomNavigationBarTheme:const BottomNavigationBarThemeData(
//    //     type: BottomNavigationBarType.fixed,
//    //     selectedItemColor: Colors.deepOrange,
//    //     elevation: 20,
//    //   ),
//    // );
//    iconBool = false;
//  }
  iconBool = !iconBool;
  emit(ChangeIcon());
 // emit(ChangeMode());
}
}
