import 'dart:async';

import 'package:flutter/material.dart';
import 'package:likekanban/blocs/auth_bloc.dart';
import 'package:likekanban/styles/colors.dart';
import 'package:likekanban/styles/tabbar.dart';
import 'package:likekanban/widgets/cards.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  static Map<String, String> tabPages = {
    '0': 'On hold',
    '1': 'In progress',
    '2': 'Needs review',
    '3': 'Approved',
  };

  static TabBar get kanbanTabBar {
    return TabBar(
      unselectedLabelColor: TabBarStyles.unselectedLabelColor,
      labelColor: TabBarStyles.labelColor,
      indicatorColor: TabBarStyles.indicatorColor,
      tabs: tabPages.values
          .map(
            (tab) => Tab(text: tab),
          )
          .toList(),
    );
  }
}

class _HomeState extends State<Home> {
  StreamSubscription _userChangedSubscription;

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
    final authBloc = Provider.of<AuthBloc>(context, listen: false);
    return DefaultTabController(
      length: Home.tabPages.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10.0,
                      top: 10.0,
                    ),
                    child: Ink(
                      decoration: ShapeDecoration(
                        color: BaseColors.lightCyan,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: authBloc.logout,
                        color: BaseColors.pureWhite,
                      ),
                    ),
                  ),
                ],
                backgroundColor: BaseColors.header,
                bottom: Home.kanbanTabBar,
                floating: true,
                pinned: true,
                snap: true,
              ),
            ];
          },
          body: TabBarView(
            children: Home.tabPages.keys
                .map(
                  (row) => Cards(row),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
