import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_bloc/cubit/cubit.dart';
import 'package:news_bloc/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var cubit = NewsCubit.get(context);
       
        return Scaffold(
          appBar: AppBar(
            title:const Text('News App'),
            actions: [
              IconButton(onPressed: () {}, icon:const Icon(Icons.search)),
              IconButton(onPressed: () {
                cubit.changeIconMode();
                cubit.changemode();
                    },
                  icon: Icon(cubit.iconBool ? cubit.iconDark : cubit.iconLight)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItem,
          ),
        );
      },
    );
  }
}
