import 'dart:convert';

import 'package:covid_tracker/models/case_model.dart';
import 'package:covid_tracker/models/general_data_model.dart';
import 'package:covid_tracker/models/news_model.dart';
import 'package:covid_tracker/models/other_case_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'api_interceptor.dart';

class ApiClient {
  static const baseUrl =
      'https://thevirustracker.com/free-api';
  Dio _dio;
  ApiClient() {
    BaseOptions options = BaseOptions(
        receiveTimeout: 100000, connectTimeout: 100000, baseUrl: baseUrl);
    _dio = Dio(options);
    // _dio.interceptors.add(ApiInterceptor());
  }
  Future<GeneralDataModel> getAllCountryData() async {
    final url = '$baseUrl?global=stats';

    try {
      final response = await _dio.get(url);
      return GeneralDataModel.fromJson(response.data);
    } on DioError catch (e) {
      print(e.error);
      throw e.error; 
    }
  }
  Future<http.Response> getCountryNews(String countryCode) async {
    final url = '$baseUrl?countryNewsTotal=$countryCode';
    return await http.get(url);
    // try {
    //   final response = await _dio.get(url);

    //   return response;
    // } on DioError catch (e) {
    //   print(e.error);
    //   throw e.error;
    // }
  }
  Future<OtherCaseModel> getConfirmedCases() async {
    final url = '$baseUrl/cases/confirmed';

    try {
      final response = await _dio.get(url);
      return OtherCaseModel.fromJson(response.data[0]);
    } on DioError catch (e) {
      print(e.error);
      throw e.error;
    }
  }
  Future<OtherCaseModel> getDeathCases() async {
    final url = '$baseUrl/deaths';

    try {
      final response = await _dio.get(url);
      return OtherCaseModel.fromJson(response.data[0]);
    } on DioError catch (e) {
      print(e.error);
      throw e.error;
    }
  }
  Future<OtherCaseModel> getRecoveredCases() async {
    final url = '$baseUrl/recovered';

    try {
      final response = await _dio.get(url);
      return OtherCaseModel.fromJson(response.data[0]);
    } on DioError catch (e) {
      print(e.error);
      throw e.error;
    }
  }
}
