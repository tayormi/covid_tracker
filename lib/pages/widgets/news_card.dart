import 'package:covid_tracker/theme/color/light_color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:covid_tracker/theme/color/light_color.dart';
import 'package:covid_tracker/utils/margin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsCard extends StatelessWidget {
  final dynamic newsItem;

  const NewsCard({Key key, @required this.newsItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          if (await canLaunch(newsItem.url))
            await launch(
              newsItem.url,
              forceSafariVC: true,
              forceWebView: true,
            );
        },
        child: Container(
          
          width: screenWidth(context),
          height: screenHeight(context, percent: 0.21),
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.09),
                  blurRadius: 20,
                  spreadRadius: 3.5,
                  offset: Offset(0, 13)),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 100,
                      margin: EdgeInsets.all(15),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xffD6D6D6).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "Nigerian News",
                        style: GoogleFonts.cabin(
                          textStyle: TextStyle(
                              color: Colors.grey[400], fontSize: 13),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            newsItem?.title ?? '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.cabin(
                                textStyle: TextStyle(
                                    color: Color(0xff243358),
                                    fontWeight: FontWeight.bold),
                                fontSize: 16),
                          ),
                          const YMargin(8),
                          Text(
                            newsItem?.time ?? "",
                            style: GoogleFonts.cabin(
                              textStyle: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 11,
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Flexible(
                flex: 4,
                child: Container(
                  height: screenHeight(context, percent: 0.21),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      image: newsItem?.image != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(newsItem?.image))
                          : null),
                ),
              )
            ],
          ),
        ));
  }
}