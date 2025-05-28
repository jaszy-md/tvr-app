import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
  final Widget? child;
  final StatefulNavigationShell? navigationShell;

  const MainLayout({
    super.key,
    this.child,
    this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    final uri = GoRouterState.of(context).uri.toString();
    final selectedIndex = _getSelectedIndex(uri);
    final Widget content = navigationShell ?? child ?? const SizedBox();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF0A0A0A),
              boxShadow: [
                BoxShadow(
                  color: Color(0x33007BFF), // 20% opacity
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
            ),
            padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/logo-title.png',
                  height: 50,
                  fit: BoxFit.contain,
                ),
                Image.asset(
                  'assets/images/QR.png',
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          Expanded(child: content),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF120C25),
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navIcon(context, '/home', Icons.home, selectedIndex == 0),
              _navIcon(context, '/agenda', Icons.calendar_today, selectedIndex == 1),
              _navIcon(context, '/winner', Icons.emoji_events, selectedIndex == 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navIcon(BuildContext context, String route, IconData icon, bool selected) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: Icon(
        icon,
        size: 32,
        color: selected ? Colors.purpleAccent : Colors.white,
      ),
    );
  }

  int _getSelectedIndex(String uri) {
    if (uri.startsWith('/home')) return 0;
    if (uri.startsWith('/agenda')) return 1;
    if (uri.startsWith('/winner')) return 2;
    return 0;
  }
}
