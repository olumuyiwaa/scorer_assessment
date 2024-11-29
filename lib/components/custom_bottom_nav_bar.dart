import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0XFFFFFFFF),
      type: BottomNavigationBarType.fixed,
      onTap: onTap, // Pass the onTap function
      currentIndex: currentIndex, // Highlight the active index
      selectedItemColor: const Color(0xFF008F8F),
      unselectedFontSize: 11,
      selectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.normal, fontSize: 11),
      items: [
        _buildBottomNavItem('home.svg', 'Home', currentIndex, 0),
        _buildBottomNavItem('matches.svg', 'Matches', currentIndex, 1),
        _buildBottomNavItem('fantasy.svg', 'Fantasy', currentIndex, 2),
        _buildBottomNavItem('shop.svg', 'Shop', currentIndex, 3),
        _buildBottomNavItem('user.png', 'My Profile', currentIndex, 4),
      ],
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(
      String iconPath, String label, int currentIndex, int index) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: SvgPicture.asset(
          'assets/icons/$iconPath',
          width: 24.0,
          height: 24.0,
          color: currentIndex == index
              ? const Color(0xFF008F8F)
              : const Color(0xFF333333),
        ),
      ),
      label: label,
    );
  }
}
