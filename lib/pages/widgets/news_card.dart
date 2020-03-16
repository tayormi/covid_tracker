import 'package:covid_tracker/theme/color/light_color.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.5),
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
                    fontSize: 16.0),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Nigeria Records Sub-Saharan Africa&rsquo;s First Coronavirus Case',
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
                            "https://thevirustracker.com/news-images/thumbs/0/nigeria-records-sub-saharan-africa-s-first-coronavirus-case-zjV8A5.jpg",
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
                        '28 February 2020' + " . " + '11:14',
                        style: TextStyle(
                            color: Colors.black45, fontWeight: FontWeight.w500),
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
    );
  }
}
