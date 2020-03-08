import 'package:covid_tracker/theme/color/light_color.dart';
import 'package:covid_tracker/theme/theme.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_screen/responsive_screen.dart';

import 'pages/screens/information.dart';
import 'pages/screens/settings.dart';
import 'pages/widgets/global_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
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
            child: Column(
              children: <Widget>[
                GlobalSituationCard(
                  cardTitle: 'SUSPECTED CASES',
                  caseTitle: 'Suspected',
                  currentData: 82156,
                  newData: 1457,
                ),
                SizedBox(height: hp(3)),
                GlobalSituationCard(
                  cardTitle: 'CONFIRMED CASES',
                  caseTitle: 'Confirmed',
                  currentData: 82156,
                  newData: 1457,
                ),
                SizedBox(height: hp(3)),
                GlobalSituationCard(
                  cardTitle: 'DEATH CASES',
                  caseTitle: 'Deaths',
                  currentData: 82156,
                  newData: 1457,
                ),
                SizedBox(height: hp(3)),
                GlobalSituationCard(
                  cardTitle: 'RECOVERED CASES',
                  caseTitle: 'Recovered',
                  currentData: 82156,
                  newData: 1457,
                ),
                SizedBox(height: hp(3)),
              ],
            )),
        InformationScreen(),
        InformationPage(),
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
  void initState() {
    super.initState();
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
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
      ),
    );
  }
}
