import 'dart:async';

import 'package:covid_tracker/pages/screens/home_screen.dart';
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
  
  int selectedIndex = 0;
  

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
        iconData: Icons.speaker_notes,
        label: 'News',
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
    
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        HomeScreen(),
        NewsPage(),
        InformationScreen(),
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
