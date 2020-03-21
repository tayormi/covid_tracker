import 'package:covid_tracker/theme/color/light_color.dart';
import 'package:covid_tracker/utils/margin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class GlobalSituationCard extends StatelessWidget {
  final String cardTitle;
  final String caseTitle;
  final int currentData;
  final int newData;
  final double percentChange;
  final Icon icon;
  final Color color;
  final Color cardColor;

  const GlobalSituationCard(
      {Key key,
      @required this.cardTitle,
      @required this.caseTitle,
      @required this.currentData,
      @required this.newData,
      @required this.percentChange,
      this.icon,
      this.cardColor = CardColors.green,
      @required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,###");

    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Container(
                width: screenWidth(context),
                height: screenHeight(context, percent: 0.21),
                margin: EdgeInsets.symmetric(horizontal:25),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 20,
                        spreadRadius: 3.5,
                        offset: Offset(0, 13)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: 40,
                          margin: EdgeInsets.all(15),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 17),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: CardColors.transparentBlack,
                              borderRadius: BorderRadius.circular(5)),
                          child: RichText(
                            text: 
                                  TextSpan(
                                    text: "$cardTitle"
                                        .toUpperCase(),
                                    style: GoogleFonts.cabin(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                               
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:20),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                currentData != null
                                    ? formatter.format(currentData)
                                    : '-',
                                style: GoogleFonts.cabin(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 29),
                                ),
                              ),
                              const YMargin(5),
                              Text(
                                caseTitle ?? "",
                                style: GoogleFonts.cabin(
                                  textStyle: TextStyle(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                newData != null
                                    ? formatter.format(newData)
                                    : '-',
                                style: GoogleFonts.cabin(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 29),
                                ),
                              ),
                              const YMargin(5),
                              Text(
                                "New",
                                style: GoogleFonts.cabin(
                                  textStyle: TextStyle(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
            children: <Widget>[
              const YMargin(115),
              Container(
                width: 58,
                height: 58,
                margin: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 30,
                        spreadRadius: 3.5,
                        offset: Offset(0, 13)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(icon.icon, color: icon.color, size: 15),
                    Text(
                      "${percentChange.round()}%",
                      style: GoogleFonts.cabin(
                        textStyle: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w300,
                            fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}