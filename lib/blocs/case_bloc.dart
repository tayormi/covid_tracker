import 'package:covid_tracker/models/case_model.dart';
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
  final CaseModel caseModel;

  const CaseLoaded({@required this.caseModel}) : assert(caseModel != null);

  @override
  List<Object> get props => [caseModel];
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
      final CaseModel caseModel = await apiRepository.getAllCases();
      yield CaseLoaded(caseModel: caseModel);
    } catch (_) {
      yield CaseError();
    }
  }

  Stream<CaseState> _mapRefreshCaseToState(RefreshCase event) async* {
    try {
      final CaseModel caseModel = await apiRepository.getAllCases();
      yield CaseLoaded(caseModel: caseModel);
    } catch (_) {
      yield state;
    }
  }
}