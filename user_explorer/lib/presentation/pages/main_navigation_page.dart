import 'package:flutter/material.dart';
import 'package:user_explorer/core/constants/app_strings.dart';
import 'package:user_explorer/presentation/pages/search_page.dart';
import 'package:user_explorer/presentation/pages/settings_page.dart';
import 'package:user_explorer/presentation/pages/user_list_page.dart';

/// Shared app shell:
/// Keeps one bottom navigation visible and clickable for all tabs.
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  void _goToExplorer() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = <Widget>[
      const UserListPage(),
      SearchPage(onBackToExplorer: _goToExplorer),
      SettingsPage(onBackToExplorer: _goToExplorer),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: AppStrings.explorer,
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: AppStrings.search,
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: AppStrings.settings,
          ),
        ],
      ),
    );
  }
}
