part of '../../main.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: navigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashView();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'versionUpdate',
          name: 'VersionUpdate',
          builder: (BuildContext context, GoRouterState state) {
            return const VersionUpdate();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/home',
      name: 'HomeView',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
      //Test icin ekledigim egranlar
      routes: [
        GoRoute(
          path: 'screen1',
          name: 'Screen1',
          builder: (BuildContext context, GoRouterState state) {
            return const Screen1();
          },
        ),
        GoRoute(
          path: 'screen2',
          name: 'Screen2',
          builder: (BuildContext context, GoRouterState state) {
            return const Screen2();
          },
        ),
      ],
    ),
  ],
);
