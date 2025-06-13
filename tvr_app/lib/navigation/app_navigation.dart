import 'package:go_router/go_router.dart';
import 'package:tvr_app/layout/main_layout.dart';
import 'package:tvr_app/views/agenda/agenda_page.dart';
import 'package:tvr_app/views/flash_screen/flash_screen.dart';
import 'package:tvr_app/views/home/home_page.dart';
import 'package:tvr_app/views/qr_code/qr_checker_page.dart';
import 'package:tvr_app/views/qr_code/qr_page.dart';
import 'package:tvr_app/views/winner/score_board.dart';
import 'package:tvr_app/views/winner/winner_page.dart';

class AppNavigation {
  AppNavigation._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),

      // Shell navigation met MainLayout voor consistente layout
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayout(navigationShell: navigationShell);
        },
        branches: [
          // Home branch
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

          // Agenda branch
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

          // Winner branch
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

          // QR en Scoreboard branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/qr',
                pageBuilder:
                    (context, state) => const NoTransitionPage(child: QRPage()),
              ),
              GoRoute(
                path: '/qr-checker',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: QRCheckerPage()),
              ),
              GoRoute(
                path: '/score_board',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: ScoreBoardPage()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
