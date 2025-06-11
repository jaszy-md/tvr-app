import 'package:go_router/go_router.dart';
import 'package:tvr_app/layout/main_layout.dart';
import 'package:tvr_app/views/home/home_page.dart';
import 'package:tvr_app/views/agenda/agenda_page.dart';
import 'package:tvr_app/views/qr_code/qr_checker_page.dart';
import 'package:tvr_app/views/qr_code/qr_page.dart';
import 'package:tvr_app/views/winner/winner_page.dart'; // jouw qr_page voor invoer

class AppNavigation {
  AppNavigation._();

  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      // Shell met bottom navigation
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

      // QR Scanner pagina buiten de shell
      GoRoute(
        path: '/qr-check',
        pageBuilder:
            (context, state) =>
                NoTransitionPage(child: MainLayout(child: QRCheckerPage())),
      ),

      // Doelpagina na geldige QR scan
      GoRoute(path: '/qr', builder: (context, state) => const QRPage()),
    ],
  );
}
