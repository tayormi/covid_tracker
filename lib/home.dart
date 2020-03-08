import 'package:covid_tracker/theme/color/light_color.dart';
import 'package:covid_tracker/theme/theme.dart';
import 'package:flutter/material.dart';

import 'pages/widgets/global_card.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.background,
      
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: LightColor.background,
        title: Text('Covid-19', style: AppTheme.h1Style.copyWith(color: LightColor.darkgrey))
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          GlobalSituationCard()
        ],)
      ),
    );
  }
}