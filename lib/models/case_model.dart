// To parse this JSON data, do
//
//     final caseModel = caseModelFromJson(jsonString);

import 'dart:convert';

List<CaseModel> caseModelFromJson(String str) => List<CaseModel>.from(json.decode(str).map((x) => CaseModel.fromJson(x)));

String caseModelToJson(List<CaseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CaseModel {
    final DateTime date;
    final int cases;

    CaseModel({
        this.date,
        this.cases,
    });

    factory CaseModel.fromJson(Map<String, dynamic> json) => CaseModel(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        cases: json["cases"] == null ? null : json["cases"],
    );

    Map<String, dynamic> toJson() => {
        "date": date == null ? null : date.toIso8601String(),
        "cases": cases == null ? null : cases,
    };
}
