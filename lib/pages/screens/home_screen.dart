import 'dart:async';

import 'package:covid_tracker/blocs/blocs.dart';
import 'package:covid_tracker/pages/widgets/global_card.dart';
import 'package:covid_tracker/utils/calculateGrowth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<void> _refreshCompleter;
  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CaseBloc>(context).add(FetchCase());
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: BlocBuilder<CaseBloc, CaseState>(
          builder: (BuildContext context, CaseState state) {
            print(state);
            if (state is CaseLoading) {
              return SizedBox(
                width: wp(100),
                height: hp(20),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.3),
                  highlightColor: Colors.white38,
                  child: GlobalSituationCard(
                    cardTitle: 'loading',
                    caseTitle: 'loading',
                    currentData: 2344,
                    newData: null,
                    percentChange: calculateGrowthPercentage(234, 5678),
                    icon: showGrowthIcon(234, 5678),
                    color: showGrowthColor(234, 5678),
                  ),
                ),
              );
            }
            if (state is CaseLoaded) {
              final currentData = state.currentData;
              final firstData = state.firstData;
              return RefreshIndicator(
                child: Column(
                  children: <Widget>[
                    GlobalSituationCard(
                      cardTitle: 'TOTAL CASES',
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
                    SizedBox(height: hp(3)),

                    GlobalSituationCard(
                      cardTitle: 'RECOVERED CASES',
                      caseTitle: 'Recovered',
                      currentData: currentData.totalRecovered,
                      newData:
                          currentData.totalRecovered - firstData.totalRecovered,
                      percentChange: calculateGrowthPercentage(
                          currentData.totalRecovered, currentData.totalRecovered - firstData.totalRecovered),
                      icon: Icon(Icons.arrow_upward, color: Colors.green,),
                      color: Colors.green,
                    ),
                    SizedBox(height: hp(3)),
                    GlobalSituationCard(
                      cardTitle: 'DEATH CASES',
                      caseTitle: 'Deaths',
                      currentData: currentData.totalDeaths,
                      newData: currentData.totalNewDeathsToday,
                      percentChange: calculateGrowthPercentage(
                          currentData.totalDeaths,
                          currentData.totalNewDeathsToday),
                      icon: showGrowthIcon(currentData.totalDeaths,
                          currentData.totalNewDeathsToday),
                      color: Colors.red,
                    ),
                    SizedBox(height: hp(3)),
                    GlobalSituationCard(
                      cardTitle: 'SERIOUS CASES',
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
                    ),
                    // GlobalSituationCard(
                    //   cardTitle: 'DEATH CASES',
                    //   caseTitle: 'Deaths',
                    //   currentData: currentData.deathCases,
                    //   newData: 1457, percentChange: calculateGrowthPercentage(currentData.deathCases, firstData.deathCases),
                    //   icon: showGrowthIcon(currentData.deathCases, firstData.deathCases), color: showGrowthColor(currentData.deathCases, firstData.deathCases),
                    // ),
                    // SizedBox(height: hp(3)),
                    // GlobalSituationCard(
                    //   cardTitle: 'RECOVERED CASES',
                    //   caseTitle: 'Recovered',
                    //   currentData: currentData.recoveredCases,
                    //   newData: 1457, percentChange: calculateGrowthPercentage(currentData.recoveredCases, firstData.recoveredCases),
                    //   icon: showGrowthIcon(currentData.recoveredCases, firstData.recoveredCases),
                    //   color: showGrowthColor(currentData.recoveredCases, firstData.recoveredCases),
                    // ),
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
                style: TextStyle(color: Colors.red),
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
}
