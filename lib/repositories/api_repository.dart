import 'package:covid_tracker/models/case_model.dart';
import 'package:covid_tracker/repositories/api_client.dart';
import 'package:flutter/material.dart';

class ApiRepository {
  final ApiClient apiClient;

  ApiRepository({@required this.apiClient}): assert(apiClient != null);
  Future<CaseModel> getAllCases() async {
    return apiClient.getAllCases();
  }
}