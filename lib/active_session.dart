import 'package:flutter/material.dart';

import 'components/custom_bottom_nav_bar.dart';
import 'screens/matches.dart';
import 'screens/not_found_page.dart';

class ActiveSession extends StatefulWidget {
  final int pageIndex;

  const ActiveSession({super.key, this.pageIndex = 1});

  @override
  State<ActiveSession> createState() => _ActiveSessionState();
}

class _ActiveSessionState extends State<ActiveSession> {
  late int _pageIndex;

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.pageIndex;
  }

  void _bottomNavTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> selectedPage = [
      const NotFoundPage(),
      const Matches(),
      const NotFoundPage(),
      const NotFoundPage(),
      const NotFoundPage(),
    ];

    return Scaffold(
      backgroundColor: const Color(0XFFFFFFFF),
      body: selectedPage[_pageIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: _bottomNavTapped,
      ),
    );
  }
}
