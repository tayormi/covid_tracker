import 'package:covid_tracker/models/news_model.dart';
import 'package:covid_tracker/theme/color/light_color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  final dynamic newsItem;

  const NewsCard({Key key, @required this.newsItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.5),
      child: InkWell(
        onTap: () async {
          if (await canLaunch(newsItem.url))
            await launch(
              newsItem.url,
              forceSafariVC: true,
              forceWebView: true,
            );
        },
        child: Card(
          color: LightColor.cardBackground,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Nigerian News',
                  style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.0),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          newsItem?.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.0),
                        ),
                        flex: 3,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                            height: 80.0,
                            width: 80.0,
                            child: Image.network(
                              newsItem?.image,
                              fit: BoxFit.cover,
                            )),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          newsItem?.time,
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Icon(Icons.share),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
