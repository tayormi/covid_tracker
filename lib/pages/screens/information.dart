import 'package:covid_tracker/pages/widgets/information_title_card.dart';
import 'package:covid_tracker/theme/color/light_color.dart';
import 'package:covid_tracker/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_screen/responsive_screen.dart';

class InformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Scaffold(
      backgroundColor: LightColor.background,
      
      // appBar: AppBar(
      //   centerTitle: true,
      //   elevation: 0,
      //   backgroundColor: LightColor.background,
      //   title: Text('Information', style: AppTheme.h1Style.copyWith(color: LightColor.darkgrey))
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: <Widget>[
            InformationTitleCard(icon: Icons.info, iconColor: Color(0xFFd7d5ed), subTitle: 'Learn how Covid-19 spread', title: 'How it Spreads?',),
            SizedBox(height: hp(3)),
            InformationTitleCard(icon: Icons.info, iconColor: Color(0xFFfee9e8), subTitle: 'Learn Covid-19 symptoms', title: 'Symptoms',),
            SizedBox(height: hp(3)),
            InformationTitleCard(icon: Icons.info, iconColor: Color(0xFFd6eede), subTitle: 'Learn Covid-19 treatments', title: 'Prevention & treatment',),
            SizedBox(height: hp(3)),
            InformationTitleCard(icon: Icons.info, iconColor: Color(0xFFe7f5fe), subTitle: 'What to do if you get the virus', title: 'What to do',),
          ],
        )
      ),
    );
  }
}