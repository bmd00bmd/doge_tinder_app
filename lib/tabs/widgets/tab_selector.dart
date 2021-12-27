import 'package:doge_tinder_app/tabs/models/app_tab.dart';
import 'package:flutter/material.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  const TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
            icon: Icon(
              _tabNavBarItemIcon(tab),
              key: Key(key.toString() + tab.toString()),
            ),
            label: _tabNavBarItemLabel(tab));
      }).toList(),
    );
  }

  IconData _tabNavBarItemIcon(AppTab tab) {
    switch (tab) {
      case AppTab.park:
        return Icons.fence_rounded;
      case AppTab.house:
        return Icons.home;
      case AppTab.about:
        return Icons.person;
      default:
        return Icons.stop;
    }
  }

  String _tabNavBarItemLabel(AppTab tab) {
    switch (tab) {
      case AppTab.park:
        return 'Doge Park';
      case AppTab.house:
        return 'Doge House';
      case AppTab.about:
        return 'About';
      default:
        return 'Error';
    }
  }
}
