import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:likekanban/widgets/cards.dart';

import 'bloc/cards_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    var authBloc = BlocProvider.of<CardsBloc>(context, listen: false);
    _userChangedSubscription = authBloc.user.listen((user) {
      if (user == null)
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false);
    });
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
          actions: [
            Container(
              child: Ink(
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                ),
                child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      BlocProvider.of<CardsBloc>(context).add(CardsEvent());
                    }),
              ),
            ),
          ],
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
