import 'dart:async';

import 'package:covid_tracker/blocs/blocs.dart';
import 'package:covid_tracker/pages/widgets/global_card.dart';
import 'package:covid_tracker/theme/color/light_color.dart';
import 'package:covid_tracker/utils/calculateGrowth.dart';
import 'package:covid_tracker/utils/margin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  Completer<void> _refreshCompleter;
  @override
  void initState() {
    
    super.initState();
    _refreshCompleter = Completer<void>();
  }
 @override
  void didChangeDependencies() {
    BlocProvider.of<CaseBloc>(context).add(FetchCase());
    //do whatever you want with the bloc here.
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        child: BlocBuilder<CaseBloc, CaseState>(
          builder: (BuildContext context, CaseState state) {
            print(state);
            if (state is CaseLoading) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  YMargin(hp(29)),
                  Center(
                      child: SpinKitSquareCircle(
                    color: CardColors.green,
                    size: 50.0,
                  )),
                ],
              );
            }
            if (state is CaseLoaded) {
              final currentData = state.currentData;
              final firstData = state.firstData;
              return RefreshIndicator(
                color: Colors.green,
                child: Column(
                  children: <Widget>[
                    GlobalSituationCard(
                      cardTitle: 'Total CASES',
                      caseTitle: 'Total',
                      currentData: currentData.totalCases,
                      newData: currentData.totalNewCasesToday,
                      percentChange: calculateGrowthPercentage(
                          currentData.totalCases,
                          currentData.totalNewCasesToday),
                      icon: showGrowthIcon(currentData.totalCases,
                          currentData.totalNewCasesToday),
                      color: Colors.red,
                    ),
                    GlobalSituationCard(
                      cardTitle: 'Recovered CASES',
                      caseTitle: 'Recovered',
                      currentData: currentData.totalRecovered,
                      newData:
                          currentData.totalRecovered - firstData.totalRecovered,
                      percentChange: calculateGrowthPercentage(
                          currentData.totalRecovered,
                          currentData.totalRecovered -
                              firstData.totalRecovered),
                      cardColor: CardColors.blue,
                      icon: Icon(
                        Icons.arrow_upward,
                        color: Colors.green,
                      ),
                      color: Colors.green,
                    ),
                    GlobalSituationCard(
                      cardTitle: 'Death CASES',
                      caseTitle: 'Deaths',
                      currentData: currentData.totalDeaths,
                      newData: currentData.totalNewDeathsToday,
                      percentChange: calculateGrowthPercentage(
                          currentData.totalDeaths,
                          currentData.totalNewDeathsToday),
                      icon: showGrowthIcon(currentData.totalDeaths,
                          currentData.totalNewDeathsToday),
                      color: Colors.red,
                      cardColor: CardColors.red,
                    ),
                    SizedBox(height: hp(3)),
                    GlobalSituationCard(
                      cardTitle: 'Serious CASES',
                      caseTitle: 'Serious',
                      currentData: currentData.totalSeriousCases,
                      newData: currentData.totalSeriousCases -
                          firstData.totalSeriousCases,
                      percentChange: calculateGrowthPercentage(
                          currentData.totalSeriousCases,
                          currentData.totalSeriousCases -
                              firstData.totalSeriousCases),
                      icon: showGrowthIcon(currentData.totalSeriousCases,
                          firstData.totalSeriousCases),
                      color: Colors.red,
                      cardColor: CardColors.cyan,
                    ),
                    SizedBox(height: hp(3)),
                  ],
                ),
                onRefresh: () {
                  BlocProvider.of<CaseBloc>(context).add(FetchCase());
                  return _refreshCompleter.future;
                },
              );
            }
            if (state is CaseError) {
              return Text(
                'Something went wrong!',
                style:
                    GoogleFonts.cabin(textStyle: TextStyle(color: Colors.red)),
              );
            }
            return Center(
                child: RefreshIndicator(
              child: Text('Pull to refresh'),
              onRefresh: () {
                BlocProvider.of<CaseBloc>(context).add(FetchCase());
                return _refreshCompleter.future;
              },
            ));
          },
          // listener: (BuildContext context, CaseState state) {
          //   if (state is CaseLoaded) {
          //     BlocProvider.of<CaseBloc>(context).add(FetchCase());
          //   }
          // }
        ));
  }

  @override
  bool get wantKeepAlive => true;
}