import 'package:flutter/material.dart';
import '../../ui/theme.dart';
import '../menu/menu_screen.dart';
import '../business/business_info_screen.dart';
import '../subscription/subscription_screen.dart';
import '../statistics/statistics_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const BusinessInfoScreen(),
    const MenuScreen(),
    const SubscriptionScreen(),
    const StatisticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('점주 대시보드'),
        backgroundColor: AppColors.cream,
        foregroundColor: AppColors.text,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.store),
            label: '가게 정보',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: '메뉴 관리',
          ),
          NavigationDestination(
            icon: Icon(Icons.subscriptions),
            label: '구독 관리',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics),
            label: '통계',
          ),
        ],
      ),
    );
  }
}