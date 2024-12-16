import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: widget.currentIndex,
        onTap: widget.onTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        selectedLabelStyle:
            const TextStyle(fontFamily: 'Poppins', fontSize: 12),
        unselectedItemColor: const Color(0xFF9E9E9E),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/home-2.svg',
              height: 24,
              colorFilter: widget.currentIndex == 0
                  ? const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                  : const ColorFilter.mode(Color(0xFF9E9E9E), BlendMode.srcIn),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/bell-1.svg',
              height: 24,
              colorFilter: widget.currentIndex == 1
                  ? const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                  : const ColorFilter.mode(Color(0xFF9E9E9E), BlendMode.srcIn),
            ),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/message-3-text.svg',
              height: 24,
              colorFilter: widget.currentIndex == 2
                  ? const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                  : const ColorFilter.mode(Color(0xFF9E9E9E), BlendMode.srcIn),
            ),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/user-4.svg',
              height: 24,
              colorFilter: widget.currentIndex == 3
                  ? const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                  : const ColorFilter.mode(Color(0xFF9E9E9E), BlendMode.srcIn),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
