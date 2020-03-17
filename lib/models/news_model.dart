// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
    final List<Countrydatum> countrydata;
    final List<Countrynewsitem> countrynewsitems;

    NewsModel({
        this.countrydata,
        this.countrynewsitems,
    });

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        countrydata: json["countrydata"] == null ? null : List<Countrydatum>.from(json["countrydata"].map((x) => Countrydatum.fromJson(x))),
        countrynewsitems: json["countrynewsitems"] == null ? null : List<Countrynewsitem>.from(json["countrynewsitems"].map((x) => Countrynewsitem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "countrydata": countrydata == null ? null : List<dynamic>.from(countrydata.map((x) => x.toJson())),
        "countrynewsitems": countrynewsitems == null ? null : List<dynamic>.from(countrynewsitems.map((x) => x.toJson())),
    };
}

class Countrydatum {
    final Info info;
    final int totalCases;
    final int totalRecovered;
    final int totalUnresolved;
    final int totalDeaths;
    final int totalNewCasesToday;
    final int totalNewDeathsToday;
    final int totalActiveCases;
    final int totalSeriousCases;

    Countrydatum({
        this.info,
        this.totalCases,
        this.totalRecovered,
        this.totalUnresolved,
        this.totalDeaths,
        this.totalNewCasesToday,
        this.totalNewDeathsToday,
        this.totalActiveCases,
        this.totalSeriousCases,
    });

    factory Countrydatum.fromJson(Map<String, dynamic> json) => Countrydatum(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        totalCases: json["total_cases"] == null ? null : json["total_cases"],
        totalRecovered: json["total_recovered"] == null ? null : json["total_recovered"],
        totalUnresolved: json["total_unresolved"] == null ? null : json["total_unresolved"],
        totalDeaths: json["total_deaths"] == null ? null : json["total_deaths"],
        totalNewCasesToday: json["total_new_cases_today"] == null ? null : json["total_new_cases_today"],
        totalNewDeathsToday: json["total_new_deaths_today"] == null ? null : json["total_new_deaths_today"],
        totalActiveCases: json["total_active_cases"] == null ? null : json["total_active_cases"],
        totalSeriousCases: json["total_serious_cases"] == null ? null : json["total_serious_cases"],
    );

    Map<String, dynamic> toJson() => {
        "info": info == null ? null : info.toJson(),
        "total_cases": totalCases == null ? null : totalCases,
        "total_recovered": totalRecovered == null ? null : totalRecovered,
        "total_unresolved": totalUnresolved == null ? null : totalUnresolved,
        "total_deaths": totalDeaths == null ? null : totalDeaths,
        "total_new_cases_today": totalNewCasesToday == null ? null : totalNewCasesToday,
        "total_new_deaths_today": totalNewDeathsToday == null ? null : totalNewDeathsToday,
        "total_active_cases": totalActiveCases == null ? null : totalActiveCases,
        "total_serious_cases": totalSeriousCases == null ? null : totalSeriousCases,
    };
}

class Info {
    final int ourid;
    final String title;
    final String code;
    final String source;

    Info({
        this.ourid,
        this.title,
        this.code,
        this.source,
    });

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        ourid: json["ourid"] == null ? null : json["ourid"],
        title: json["title"] == null ? null : json["title"],
        code: json["code"] == null ? null : json["code"],
        source: json["source"] == null ? null : json["source"],
    );

    Map<String, dynamic> toJson() => {
        "ourid": ourid == null ? null : ourid,
        "title": title == null ? null : title,
        "code": code == null ? null : code,
        "source": source == null ? null : source,
    };
}

class Countrynewsitem {
    final NewsItem newsItem;
    final String stat;

    Countrynewsitem({
        this.newsItem,
        this.stat,
    });

    factory Countrynewsitem.fromJson(Map<String, dynamic> json) => Countrynewsitem(
        newsItem: json["8"] == null ? null : NewsItem.fromJson(json["8"]),
        stat: json["stat"] == null ? null : json["stat"],
    );

    Map<String, dynamic> toJson() => {
        "1": newsItem == null ? null : newsItem.toJson(),
        "stat": stat == null ? null : stat,
    };
}

class NewsItem {
    final String newsid;
    final String title;
    final String image;
    final String time;
    final String url;

    NewsItem({
        this.newsid,
        this.title,
        this.image,
        this.time,
        this.url
        
    });

    factory NewsItem.fromJson(Map<String, dynamic> json) => NewsItem(
        newsid: json["newsid"] == null ? null : json["newsid"],
        title: json["title"] == null ? null : json["title"],
        image: json["image"] == null ? null : json["image"],
        time: json["time"] == null ? null : json["time"],
        url: json["url"] == null ? null : json["url"],
    );

    Map<String, dynamic> toJson() => {
        "newsid": newsid == null ? null : newsid,
        "title": title == null ? null : title,
        "image": image == null ? null : image,
        "time": time == null ? null : time,
        "url": url == null ? null : url,
    };
}
