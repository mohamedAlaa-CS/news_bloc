import 'package:flutter/material.dart';
import 'package:news_bloc/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_bloc/screens/science/science_screen.dart';
import 'package:news_bloc/screens/sports/sports_screen.dart';
import 'package:news_bloc/shared_prefrance/cach_helper.dart';
import '../Dio/dio_helper.dart';
import '../screens/business/business_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItem = const [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'science'),
  ];

  List<Widget> screens = const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
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
        'apiKey': 'b20a00633baa48ed9c7e1ce6db0b3825'
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

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'sa',
          'category': 'sports',
          'apiKey': 'b20a00633baa48ed9c7e1ce6db0b3825'
        },
      ).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetDataSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'sa',
          'category': 'science',
          'apiKey': 'b20a00633baa48ed9c7e1ce6db0b3825'
        },
      ).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetDataScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  IconData iconLight = Icons.wb_sunny;
  IconData iconDark = Icons.nights_stay;

  var light = ThemeMode.light;
  var dark = ThemeMode.dark;

  bool iconBool = true;

  changeIconMode() {
    iconBool = !iconBool;
    emit(ChangeIcon());
  }

  bool isDark = false;
  changemode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppMode());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ChangeAppMode());
      });
    }
  }
}
