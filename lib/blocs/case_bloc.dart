import 'package:covid_tracker/models/case_model.dart';
import 'package:covid_tracker/models/home_data_model.dart';
import 'package:covid_tracker/repositories/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CaseEvent extends Equatable{
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
  final HomeDataModel homeData;

  const CaseLoaded({@required this.homeData}) : assert(homeData != null);

  @override
  List<Object> get props => [homeData];
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
    yield CaseLoading();
    try {
      final caseModel = await apiRepository.getAllCases();
      final suspectedCases = await apiRepository.getSuspectedCases();
      final deathCases = await apiRepository.getDeathCases();
      final confirmedCases = await apiRepository.getConfirmedCases();
      final recoveredCases = await apiRepository.getRecoveredCases();
      final homeData = new HomeDataModel(caseModel.date, suspectedCases.cases, confirmedCases.cases, deathCases.cases, recoveredCases.cases);
      yield CaseLoaded(homeData: homeData);
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
}