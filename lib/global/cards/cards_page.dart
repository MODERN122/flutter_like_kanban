import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:likekanban/global/cards/cards.dart';

import 'bloc/cards_bloc.dart';

class CardsPage extends StatefulWidget {
  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  StreamSubscription _userChangedSubscription;

  TabBar kanbanTabBar(Map<String, String> tabs) {
    return TabBar(
      tabs: tabs.values
          .map(
            (tab) => Tab(text: tab),
          )
          .toList(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _userChangedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tabPages = {
      '0': FlutterI18n.translate(context, "tabbar.home.0"),
      '1': FlutterI18n.translate(context, "tabbar.home.1"),
      '2': FlutterI18n.translate(context, "tabbar.home.2"),
      '3': FlutterI18n.translate(context, "tabbar.home.3"),
    };
    return DefaultTabController(
      length: tabPages.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: kanbanTabBar(tabPages),
        ),
        body: TabBarView(
          children: tabPages.keys
              .map(
                (row) => Cards(row),
              )
              .toList(),
        ),
      ),
    );
  }
}
