abstract class NewsStates {}

class NewsInitialState extends NewsStates{}

class NewsBottomNavState extends NewsStates{}

class NewsGetBusinessLoadingState extends NewsStates{}

class NewsGetBusinessSuccessState extends NewsStates{}

class NewsGetDataBusinessErrorState extends NewsStates{
  final String error;
  NewsGetDataBusinessErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates{}

class NewsGetSportsSuccessState extends NewsStates{}

class NewsGetDataSportsErrorState extends NewsStates{
  final String error;
  NewsGetDataSportsErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates{}

class NewsGetScienceSuccessState extends NewsStates{}

class NewsGetDataScienceErrorState extends NewsStates{
  final String error;
  NewsGetDataScienceErrorState(this.error);
}

class ChangeIcon extends NewsStates{}
class ChangeAppMode extends NewsStates{}