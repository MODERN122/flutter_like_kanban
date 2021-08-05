import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:likekanban/blocs/auth_bloc.dart';
import 'package:likekanban/styles/colors.dart';
import 'package:likekanban/styles/tabbar.dart';
import 'package:likekanban/widgets/cards.dart';
import 'package:provider/provider.dart';

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
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
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
          title: Text(FlutterI18n.translate(context, "textfield.login.title")),
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
