import 'package:covid_tracker/pages/screens/home_screen.dart';
import 'package:covid_tracker/theme/color/light_color.dart';
import 'package:covid_tracker/theme/theme.dart';
import 'package:covid_tracker/utils/margin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'blocs/blocs.dart';
import 'pages/screens/information_screen.dart';
import 'pages/screens/news_screen.dart';
import 'pages/screens/settings_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  void addPostFrameCallback(FrameCallback callback) {
    // Load data on widget load
    print('relad?');
    BlocProvider.of<CaseBloc>(context).add(FetchCase());
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: <Widget>[
                const YMargin(60),
                Text(
                  'Covid-19',
                  style: GoogleFonts.cabin(
                    textStyle:
                        TextStyle(fontSize: 21, color: Color(0xff989CAC)),
                  ),
                ),
                const YMargin(4),
                Text(
                  'Tracker',
                  style: GoogleFonts.cabin(
                    textStyle: TextStyle(
                        fontSize: 27,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const YMargin(10),
          Expanded(child: buildPageView()),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10)
                .add(EdgeInsets.only(top: 5)),
            child: GNav(
                gap: 10,
                activeColor: Colors.white,
                color: Colors.grey[400],
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.grey[800],
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                    backgroundColor: CardColors.red,
                  ),
                  GButton(
                    icon: LineIcons.newspaper_o,
                    text: 'News',
                    backgroundColor: CardColors.cyan,
                  ),
                  GButton(
                    icon: LineIcons.list_ul,
                    text: 'Guides',
                    backgroundColor: CardColors.blue,
                  ),
                  GButton(
                    icon: LineIcons.cog,
                    text: 'Settings',
                    backgroundColor: CardColors.green,
                  ),
                ],
                selectedIndex: selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    pageController.jumpToPage(index);
                  });
                }),
          ),
        ),
      ),
    );
  }
}
