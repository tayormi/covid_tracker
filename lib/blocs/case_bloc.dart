import 'dart:convert';

import 'package:covid_tracker/models/case_model.dart';
import 'package:covid_tracker/models/home_data_model.dart';
import 'package:covid_tracker/repositories/api_repository.dart';
import 'package:covid_tracker/utils/storageutil.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CaseEvent extends Equatable {
  const CaseEvent();
}

class FetchCase extends CaseEvent {
  @override
  List<Object> get props => [];
}

class RefreshCase extends CaseEvent {
  @override
  List<Object> get props => [];
}

abstract class CaseState extends Equatable {
  const CaseState();

  @override
  List<Object> get props => [];
}

class CaseEmpty extends CaseState {}

class CaseLoading extends CaseState {}

class CaseLoaded extends CaseState {
  final HomeDataModel currentData;
  final HomeDataModel firstData;

  CaseLoaded({@required this.currentData, @required this.firstData});

  @override
  List<Object> get props => [currentData, firstData];
}

class CaseError extends CaseState {}

class CaseBloc extends Bloc<CaseEvent, CaseState> {
  final ApiRepository apiRepository;

  CaseBloc({@required this.apiRepository}) : assert(apiRepository != null);
  @override
  CaseState get initialState => CaseEmpty();

  @override
  Stream<CaseState> mapEventToState(CaseEvent event) async* {
    if (event is FetchCase) {
      yield* _mapFetchCaseToState(event);
    } else if (event is RefreshCase) {
      yield* _mapRefreshCaseToState(event);
    }
  }

  Stream<CaseState> _mapFetchCaseToState(FetchCase event) async* {
    var firstData = new HomeDataModel();
    yield CaseLoading();
    try {
      final caseModel = await apiRepository.getAllCases();
      final suspectedCases = await apiRepository.getSuspectedCases();
      final deathCases = await apiRepository.getDeathCases();
      final confirmedCases = await apiRepository.getConfirmedCases();
      final recoveredCases = await apiRepository.getRecoveredCases();
      final currentData = new HomeDataModel(
          date: caseModel.date,
          suspectedCases: suspectedCases.data,
          confirmedCases: confirmedCases.data,
          deathCases: deathCases.data,
          recoveredCases: recoveredCases.data);
      final dt = StorageUtil.getString("FirstData");
      if(dt.isNotEmpty) {
        // Check if there's a first data and save first Data in Shared Preferences
        StorageUtil.putString("FirstData", homeDataModelToJson(currentData));
        firstData = homeDataModelFromJson(dt);
        
      }
      //Save current Data as we will need it later
      StorageUtil.putString("CurrentData", homeDataModelToJson(currentData));
      yield CaseLoaded(currentData: currentData, firstData: firstData);
    } catch (_) {
      yield CaseError();
    }
  }

  Stream<CaseState> _mapRefreshCaseToState(RefreshCase event) async* {
    try {
      // final CaseModel caseModel = await apiRepository.getAllCases();
      // yield CaseLoaded(caseModel: caseModel);
    } catch (_) {
      yield state;
    }
  }

  calculateDataHistory() {
    // return history of data
  }
}
