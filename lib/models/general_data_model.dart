// To parse this JSON data, do
//
//     final generalDataModel = generalDataModelFromJson(jsonString);

import 'dart:convert';

GeneralDataModel generalDataModelFromJson(String str) => GeneralDataModel.fromJson(json.decode(str));

String generalDataModelToJson(GeneralDataModel data) => json.encode(data.toJson());

class GeneralDataModel {
    final List<Result> results;
    final String stat;

    GeneralDataModel({
        this.results,
        this.stat,
    });

    factory GeneralDataModel.fromJson(Map<String, dynamic> json) => GeneralDataModel(
        results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        stat: json["stat"] == null ? null : json["stat"],
    );

    Map<String, dynamic> toJson() => {
        "results": results == null ? null : List<dynamic>.from(results.map((x) => x.toJson())),
        "stat": stat == null ? null : stat,
    };
}

class Result {
    final int totalCases;
    final int totalRecovered;
    final int totalUnresolved;
    final int totalDeaths;
    final int totalNewCasesToday;
    final int totalNewDeathsToday;
    final int totalActiveCases;
    final int totalSeriousCases;
    final Source source;

    Result({
        this.totalCases,
        this.totalRecovered,
        this.totalUnresolved,
        this.totalDeaths,
        this.totalNewCasesToday,
        this.totalNewDeathsToday,
        this.totalActiveCases,
        this.totalSeriousCases,
        this.source,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        totalCases: json["total_cases"] == null ? null : json["total_cases"],
        totalRecovered: json["total_recovered"] == null ? null : json["total_recovered"],
        totalUnresolved: json["total_unresolved"] == null ? null : json["total_unresolved"],
        totalDeaths: json["total_deaths"] == null ? null : json["total_deaths"],
        totalNewCasesToday: json["total_new_cases_today"] == null ? null : json["total_new_cases_today"],
        totalNewDeathsToday: json["total_new_deaths_today"] == null ? null : json["total_new_deaths_today"],
        totalActiveCases: json["total_active_cases"] == null ? null : json["total_active_cases"],
        totalSeriousCases: json["total_serious_cases"] == null ? null : json["total_serious_cases"],
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
    );

    Map<String, dynamic> toJson() => {
        "total_cases": totalCases == null ? null : totalCases,
        "total_recovered": totalRecovered == null ? null : totalRecovered,
        "total_unresolved": totalUnresolved == null ? null : totalUnresolved,
        "total_deaths": totalDeaths == null ? null : totalDeaths,
        "total_new_cases_today": totalNewCasesToday == null ? null : totalNewCasesToday,
        "total_new_deaths_today": totalNewDeathsToday == null ? null : totalNewDeathsToday,
        "total_active_cases": totalActiveCases == null ? null : totalActiveCases,
        "total_serious_cases": totalSeriousCases == null ? null : totalSeriousCases,
        "source": source == null ? null : source.toJson(),
    };
}

class Source {
    final String url;

    Source({
        this.url,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        url: json["url"] == null ? null : json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
    };
}
