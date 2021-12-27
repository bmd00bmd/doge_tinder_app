import 'package:doge_tinder_app/house/bloc/house_bloc.dart';
import 'package:doge_tinder_app/park/bloc/park_bloc.dart';
import 'package:flutter/material.dart';
import 'package:doge_tinder_app/tabs/tabs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'house/widgets/house_list.dart';
import 'park/widgets/park_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doge Tinder',
      routes: {
        '/': (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                create: (context) => TabBloc(),
              ),
              BlocProvider<ParkBloc>(
                create: (context) => ParkBloc(),
              ),
              BlocProvider<HouseBloc>(
                create: (context) => HouseBloc(),
              ),
            ],
            child: HomeScreen(),
          );
        },
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              _tabNavBarItemLabel(activeTab),
            ),
            actions: [],
          ),
          body: _getActiveTabWidget(activeTab, context),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) => BlocProvider.of<TabBloc>(context).add(
              TabUpdated(tab),
            ),
          ),
        );
      },
    );
  }

  Widget _getActiveTabWidget(AppTab activeTab, BuildContext context) {
    switch (activeTab) {
      case AppTab.park:
        BlocProvider.of<ParkBloc>(context).add(
          ParkDogeArrival(),
        );
        return ParkList();
      case AppTab.house:
        BlocProvider.of<HouseBloc>(context).add(
          WelcomeHome(),
        );
        return HouseList();
      case AppTab.about:
        return Center(child: Text('About'));
      default:
        return Center(child: Text('Error'));
    }
  }

  String _tabNavBarItemLabel(AppTab tab) {
    switch (tab) {
      case AppTab.park:
        return 'Doge Park';
      case AppTab.house:
        return 'Doge House';
      case AppTab.about:
        return 'About Developer';
      default:
        return 'Error';
    }
  }
}
