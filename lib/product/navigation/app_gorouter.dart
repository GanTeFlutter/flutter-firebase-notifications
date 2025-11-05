part of '../../main.dart';

final GoRouter _router = GoRouter(
  navigatorKey: AppKeys.navigatorKey,
  routes: <RouteBase>[
    // Splash sayfası ShellRoute dışında (bildirim almayacak)
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashView();
      },
    ),
    // Kapsayıcı route - tüm diğer sayfaları sarar
    ShellRoute(
      builder: (context, state, child) {
        return AppListenerWrapper(child: child);
      },
      routes: [
        GoRoute(
          path: '/versionUpdate',
          name: 'VersionUpdate',
          builder: (BuildContext context, GoRouterState state) {
            return const VersionUpdate();
          },
        ),
        GoRoute(
          path: '/home',
          name: 'HomeView',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeView();
          },
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
    ),
  ],
);

/*
Kullanımı:
context.goNamed('HomeView');
context.goNamed('VersionUpdate');
context.goNamed('Screen1');
context.goNamed('Screen2');

Path yapısı:
- '/' -> SplashView (ShellRoute dışında)
- '/versionUpdate' -> VersionUpdate (ShellRoute içinde)
- '/home' -> HomeView (ShellRoute içinde)
- '/home/screen1' -> Screen1 (ShellRoute içinde)
- '/home/screen2' -> Screen2 (ShellRoute içinde)

Not: SplashView dışındaki tüm sayfalar AppListenerWrapper tarafından sarılacak
ve bildirim listener'larından faydalanacak.
*/
