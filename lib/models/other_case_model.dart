// To parse this JSON data, do
//
//     final otherCaseModel = otherCaseModelFromJson(jsonString);

import 'dart:convert';

List<OtherCaseModel> otherCaseModelFromJson(String str) => List<OtherCaseModel>.from(json.decode(str).map((x) => OtherCaseModel.fromJson(x)));

String otherCaseModelToJson(List<OtherCaseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OtherCaseModel {
    final DateTime date;
    final int data;

    OtherCaseModel({
        this.date,
        this.data,
    });

    factory OtherCaseModel.fromJson(Map<String, dynamic> json) => OtherCaseModel(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        data: json["data"] == null ? null : json["data"],
    );

    Map<String, dynamic> toJson() => {
        "date": date == null ? null : date.toIso8601String(),
        "data": data == null ? null : data,
    };
}
