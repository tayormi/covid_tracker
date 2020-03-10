// class HomeDataModel {
//   final DateTime date;
//   final int suspectedCases;
//   final int confirmedCases;
//   final int deathCases;
//   final int recoveredCases;

//   HomeDataModel(this.date, this.suspectedCases, this.confirmedCases, this.deathCases, this.recoveredCases);
//    Map<String, dynamic> toJson() => {
//         "date": date == null ? null : date.toIso8601String(),
//         "suspectedCases": suspectedCases == null ? null : suspectedCases,
//         "confirmedCases": confirmedCases == null ? null : confirmedCases,
//         "deathCases": deathCases == null ? null : deathCases,
//         "recoveredCases": recoveredCases == null ? null : recoveredCases,
//     };

// }
// To parse this JSON data, do
//
//     final otherCaseModel = otherCaseModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final homeDataModel = homeDataModelFromJson(jsonString);

import 'dart:convert';

HomeDataModel homeDataModelFromJson(String str) => HomeDataModel.fromJson(json.decode(str));

String homeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

class HomeDataModel {
    final DateTime date;
    final int suspectedCases;
    final int confirmedCases;
    final int deathCases;
    final int recoveredCases;

    HomeDataModel({
        this.date,
        this.suspectedCases,
        this.confirmedCases,
        this.deathCases,
        this.recoveredCases,
    });

    factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        suspectedCases: json["suspectedCases"] == null ? null : json["suspectedCases"],
        confirmedCases: json["confirmedCases"] == null ? null : json["confirmedCases"],
        deathCases: json["deathCases"] == null ? null : json["deathCases"],
        recoveredCases: json["recoveredCases"] == null ? null : json["recoveredCases"],
    );

    Map<String, dynamic> toJson() => {
        "date": date == null ? null : date.toIso8601String(),
        "suspectedCases": suspectedCases == null ? null : suspectedCases,
        "confirmedCases": confirmedCases == null ? null : confirmedCases,
        "deathCases": deathCases == null ? null : deathCases,
        "recoveredCases": recoveredCases == null ? null : recoveredCases,
    };
}
