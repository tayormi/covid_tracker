import 'dart:async';

import 'package:covid_tracker/blocs/blocs.dart';
import 'package:covid_tracker/models/ncovid_data.dart';
import 'package:covid_tracker/models/serializers.dart';
import 'package:covid_tracker/pages/widgets/global_card.dart';
import 'package:covid_tracker/pages/widgets/news_card.dart';
import 'package:covid_tracker/utils/calculateGrowth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:shimmer/shimmer.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Completer<void> _refreshCompleter;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NewsBloc>(context).add(FetchNews());
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: BlocBuilder<NewsBloc, NewsState>(
            builder: (BuildContext context, NewsState state) {
          if (state is NewsLoaded) {
            return Container(
              height: hp(100),
              width: wp(100),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final newsItem = serializers.deserializeWith(
                        CountryNewsItem.serializer,
                        state.news.first[
                            (state.news.first.keys.length - 1 - index)
                                .toString()]);
                    print(newsItem);
                    return Column(children: <Widget>[
                      NewsCard(
                        newsItem: newsItem,
                      )
                    ]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: hp(1));
                  },
                  itemCount: state.news.first.keys.length),
            );
          }
          if (state is NewsLoading) {
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
        }));
  }
}
