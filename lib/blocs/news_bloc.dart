import 'dart:convert';

import 'package:covid_tracker/models/news_model.dart';
import 'package:covid_tracker/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class FetchNews extends NewsEvent {
  @override
  List<Object> get props => [];
}

class RefreshNews extends NewsEvent {
  @override
  List<Object> get props => [];
}

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsEmpty extends NewsState {}

class NewsLoading extends NewsState {}
class NewsLoaded extends NewsState {
  final List<dynamic> news;

  NewsLoaded({@required this.news});

  @override
  List<Object> get props => [news];
}

class NewsError extends NewsState {}

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final ApiRepository apiRepository;

  NewsBloc({@required this.apiRepository}) : assert(apiRepository != null);
  @override
  NewsState get initialState => NewsEmpty();

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is FetchNews) {
      yield* _mapFetchNewsToState(event);
    } else if (event is RefreshNews) {
      yield* _mapRefreshNewsToState(event);
    }
  }

  Stream<NewsState> _mapFetchNewsToState(FetchNews event) async* {
    yield NewsLoading();
    try {
      final news = await apiRepository.getCountryNews();
      final data = json.decode(news.body)['countrynewsitems'];
      // print(data);
      //Save current Data as we will need it later
      yield NewsLoaded(news: data);
    } catch (_) {
      yield NewsError();
    }
  }

  Stream<NewsState> _mapRefreshNewsToState(RefreshNews event) async* {
    try {
      // final NewsModel NewsModel = await apiRepository.getAllNewss();
      // yield NewsLoaded(NewsModel: NewsModel);
    } catch (_) {
      yield state;
    }
  }
}