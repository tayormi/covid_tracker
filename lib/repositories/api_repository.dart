import 'package:covid_tracker/models/case_model.dart';
import 'package:covid_tracker/repositories/api_client.dart';
import 'package:flutter/material.dart';

class ApiRepository {
  final ApiClient apiClient;

  ApiRepository({@required this.apiClient}): assert(apiClient != null);
  Future<CaseModel> getAllCases() async {
    return apiClient.getAllCases();
  }
  Future<CaseModel> getRecoveredCases() async {
    return apiClient.getRecoveredCases();
  }
  Future<CaseModel> getConfirmedCases() async {
    return apiClient.getConfirmedCases();
  }
  Future<CaseModel> getDeathCases() async {
    return apiClient.getDeathCases();
  }
  Future<CaseModel> getSuspectedCases() async {
    return apiClient.getSuspectedCases();
  }
  
}