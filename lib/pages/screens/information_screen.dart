import 'package:covid_tracker/pages/widgets/information_title_card.dart';
import 'package:covid_tracker/theme/color/light_color.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_screen/responsive_screen.dart';

class InformationScreen extends StatefulWidget {
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Scaffold(
    
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: <Widget>[
            InformationTitleCard(icon: LineIcons.share_alt, iconColor: CardColors.blue, subTitle: 'Learn how Covid-19 spread', title: 'How it Spreads?',),
            SizedBox(height: hp(3)),
            InformationTitleCard(icon: LineIcons.warning, iconColor: CardColors.cyan, subTitle: 'Learn Covid-19 symptoms', title: 'Symptoms',),
            SizedBox(height: hp(3)),
            InformationTitleCard(icon: LineIcons.heartbeat, iconColor: CardColors.red, subTitle: 'Learn Covid-19 treatments', title: 'Prevention & treatment',),
            SizedBox(height: hp(3)),
            InformationTitleCard(icon: LineIcons.question_circle, iconColor:CardColors.green, subTitle: 'What to do if you get the virus', title: 'What to do',),
          ],
        )
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}