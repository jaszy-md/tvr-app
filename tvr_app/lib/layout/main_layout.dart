import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
  final Widget? child;
  final StatefulNavigationShell? navigationShell;

  const MainLayout({super.key, this.child, this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final uri = GoRouterState.of(context).uri.toString();
    final selectedIndex = _getSelectedIndex(uri);
    final Widget content = navigationShell ?? child ?? const SizedBox();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Column(
        children: [
          // Header + overlapping image
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF0A0A0A),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x33007BFF),
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
                      height: 60,
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
              Positioned(
                bottom: -40,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    'assets/images/reboot-img.png',
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ), // zodat content niet onder de afbeelding start
          // Main content
          Expanded(child: content),
        ],
      ),

      // Bottom navigation bar with full-height gradient
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0A0A), Color(0xFF3B098C), Color(0xFF007AFF)],
            stops: [0.0, 0.58, 1.0],
          ),
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => context.go('/home'),
                child: Icon(
                  Icons.home,
                  size: 36,
                  color: selectedIndex == 0 ? Color(0xFFCB5EFF) : Colors.white,
                ),
              ),
              const SizedBox(width: 60),
              GestureDetector(
                onTap: () => context.go('/winner'),
                child: Icon(
                  Icons.emoji_events,
                  size: 36,
                  color: selectedIndex == 2 ? Color(0xFFCB5EFF) : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButton: GestureDetector(
        onTap: () => context.go('/agenda'),
        child: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF5C5CFF), Color(0xFFCB5EFF)],
            ),
            border: Border.all(color: Color(0xFF007AFF), width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.9),
                blurRadius: 5,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              'assets/images/taskplanning.png',
              width: 34,
              height: 34,
              color: selectedIndex == 1 ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  int _getSelectedIndex(String uri) {
    if (uri.startsWith('/home')) return 0;
    if (uri.startsWith('/agenda')) return 1;
    if (uri.startsWith('/winner')) return 2;
    return 0;
  }
}
