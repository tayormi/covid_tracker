import 'package:covid_tracker/theme/color/light_color.dart';
import 'package:covid_tracker/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_screen/responsive_screen.dart';

class GlobalSituationCard extends StatelessWidget {
  final String cardTitle;
  final String caseTitle;
  final int currentData;
  final int newData;

  const GlobalSituationCard({Key key, @required this.cardTitle, @required this.caseTitle, @required this.currentData, @required this.newData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Container(
      height: hp(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(this.cardTitle, style: AppTheme.titleStyle.copyWith(color: LightColor.darkgrey,)),
          SizedBox(height: hp(4)),
          Expanded(
                      child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(this.currentData != null ? this.currentData.toString() : '-', style: AppTheme.titleStyle.copyWith(fontSize: 20, color: Colors.black)),
                    SizedBox(height: hp(1)),
                    Text(this.caseTitle, style: AppTheme.titleStyle.copyWith(fontSize: 14, color: LightColor.darkgrey)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.arrow_downward, color: Colors.green,),
                    SizedBox(height: hp(1)),
                    Text('20%', style: AppTheme.titleStyle.copyWith(fontSize: 14, color: Colors.green)),
                  ],
                ),
                SizedBox(height: wp(10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(this.newData != null ? this.newData.toString() : '-', style: AppTheme.titleStyle.copyWith(fontSize: 20, color: Colors.black)),
                    SizedBox(height: hp(1)),
                    Text('New', style: AppTheme.titleStyle.copyWith(fontSize: 14, color: LightColor.darkgrey)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.arrow_upward, color: Colors.red,),
                    SizedBox(height: hp(1)),
                    Text('10%', style: AppTheme.titleStyle.copyWith(fontSize: 14, color: Colors.red)),
                  ],
                ),
              ],
            ),
          )
        ]
      )
    );
  }
}
