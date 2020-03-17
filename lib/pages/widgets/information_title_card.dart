import 'package:covid_tracker/theme/color/light_color.dart';
import 'package:covid_tracker/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_screen/responsive_screen.dart';

class InformationTitleCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Color iconColor;

  const InformationTitleCard({Key key, @required this.title, @required this.subTitle, @required this.icon, @required this.iconColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Container(
      height: hp(13),
      width: wp(100),
      padding: EdgeInsets.all(20),
      //margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: LightColor.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          new BoxShadow(
              color: Colors.grey[100],
              blurRadius: 4.0,
              spreadRadius: 3.5,
              offset: Offset(0.0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
                      child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(icon, size: 50, color: iconColor,),
                SizedBox(width: wp(5)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: AppTheme.h2Style.copyWith(color: LightColor.darkgrey, fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: hp(1)),
                    Text(subTitle, style: AppTheme.h2Style.copyWith(color: LightColor.darkgrey.withOpacity(0.5), fontSize: 16))
                  ],
                )
              ]
            ),
          )
        ]
      ),
    );
  }
}