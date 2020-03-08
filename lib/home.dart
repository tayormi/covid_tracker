import 'package:covid_tracker/theme/color/light_color.dart';
import 'package:covid_tracker/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_screen/responsive_screen.dart';

import 'pages/widgets/global_card.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Scaffold(
      backgroundColor: LightColor.background,
      
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: LightColor.background,
        title: Text('Covid-19', style: AppTheme.h1Style.copyWith(color: LightColor.darkgrey))
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(children: <Widget>[
          GlobalSituationCard(cardTitle: 'SUSPECTED CASES', caseTitle: 'Suspected', currentData: 82156, newData: 1457,),
          SizedBox(height: hp(3)),
          GlobalSituationCard(cardTitle: 'CONFIRMED CASES', caseTitle: 'Confirmed', currentData: 82156, newData: 1457,),
          SizedBox(height: hp(3)),
          GlobalSituationCard(cardTitle: 'DEATH CASES', caseTitle: 'Deaths', currentData: 82156, newData: 1457,),
          SizedBox(height: hp(3)),
          GlobalSituationCard(cardTitle: 'RECOVERED CASES', caseTitle: 'Recovered', currentData: 82156, newData: 1457,),
          SizedBox(height: hp(3)),
        ],)
      ),
    );
  }
}