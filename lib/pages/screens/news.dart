import 'package:covid_tracker/pages/widgets/news_card.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        
        children: <Widget>[
          NewsCard()
        ]
      ),
    );
  }
}