// To parse this JSON data, do
//
//     final caseModel = caseModelFromJson(jsonString);

import 'dart:convert';

class CaseModel {
    final DateTime date;
    final int cases;

    CaseModel({
        this.date,
        this.cases,
    });

    factory CaseModel.fromJson(String str) => CaseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CaseModel.fromMap(Map<String, dynamic> json) => CaseModel(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        cases: json["cases"] == null ? null : json["cases"],
    );

    Map<String, dynamic> toMap() => {
        "date": date == null ? null : date.toIso8601String(),
        "cases": cases == null ? null : cases,
    };
}
