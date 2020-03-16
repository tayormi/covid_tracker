import 'dart:async';

import 'package:covid_tracker/theme/color/light_color.dart';
import 'package:covid_tracker/theme/theme.dart';
import 'package:covid_tracker/utils/calculateGrowth.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:shimmer/shimmer.dart';

import 'blocs/blocs.dart';
import 'pages/screens/information.dart';
import 'pages/screens/news.dart';
import 'pages/screens/settings.dart';
import 'pages/widgets/global_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<void> _refreshCompleter;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  void addPostFrameCallback(FrameCallback callback) {
    // Load data on widget load
    BlocProvider.of<CaseBloc>(context).add(FetchCase());
  }

  List<FFNavigationBarItem> buildBottomNavBarItems() {
    return [
      FFNavigationBarItem(
        iconData: Icons.home,
        label: 'Home',
      ),
      FFNavigationBarItem(
        iconData: Icons.note,
        label: 'Guides',
      ),
      FFNavigationBarItem(
        iconData: Icons.speaker_notes,
        label: 'News',
      ),
      FFNavigationBarItem(
        iconData: Icons.settings,
        label: 'Settings',
      ),
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    BlocProvider.of<CaseBloc>(context).add(FetchCase());
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        SingleChildScrollView(
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
                          newData: currentData.totalRecovered -
                              firstData.totalRecovered,
                          percentChange: calculateGrowthPercentage(
                              currentData.totalRecovered,
                                  firstData.totalRecovered),
                          icon: showGrowthIcon(currentData.totalRecovered,
                              firstData.totalRecovered),
                          color: Colors.red,
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
            )),
        InformationScreen(),
        NewsPage(),
        SettingsPage(),
      ],
    );
  }

  void pageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      selectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.background,
      appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: LightColor.background,
          title: Text('Covid-19 Tracker',
              style: AppTheme.h1Style.copyWith(color: LightColor.darkgrey))),
      body: buildPageView(),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Color(0xFFfee9e8),
          selectedItemBackgroundColor: Color(0xFF62bd80),
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
        ),
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          // if (index == 0) {
          //   BlocProvider.of<CaseBloc>(context).add(FetchCase());
          // }
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
      ),
    );
  }
}
