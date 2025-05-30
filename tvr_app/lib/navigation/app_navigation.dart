import 'package:go_router/go_router.dart';
import 'package:tvr_app/layout/main_layout.dart';
import 'package:tvr_app/views/home/home_page.dart';
import 'package:tvr_app/views/agenda/agenda_page.dart';
import 'package:tvr_app/views/winner/winner_page.dart';

class AppNavigation {
  AppNavigation._();

  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayout(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: HomePage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/agenda',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: AgendaPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/winner',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: WinnerPage()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
