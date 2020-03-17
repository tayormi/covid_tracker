import 'package:covid_tracker/models/case_model.dart';
import 'package:covid_tracker/models/general_data_model.dart';
import 'package:covid_tracker/models/news_model.dart';
import 'package:covid_tracker/models/other_case_model.dart';
import 'package:covid_tracker/repositories/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiRepository {
  final ApiClient apiClient;

  ApiRepository({@required this.apiClient}): assert(apiClient != null);
  Future<GeneralDataModel> getAllCountryData() async {
    return apiClient.getAllCountryData();
  }
  Future<OtherCaseModel> getRecoveredCases() async {
    return apiClient.getRecoveredCases();
  }
  Future<OtherCaseModel> getConfirmedCases() async {
    return apiClient.getConfirmedCases();
  }
  Future<OtherCaseModel> getDeathCases() async {
    return apiClient.getDeathCases();
  }
  Future<http.Response> getCountryNews() async {
    return apiClient.getCountryNews('NG');
  }
  // Future<OtherCaseModel> getSuspectedCases() async {
  //   return apiClient.getSuspectedCases();
  // }
  
}