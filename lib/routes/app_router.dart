import 'package:auto_route/auto_route.dart';
import 'package:myapp/app.dart';
import 'package:myapp/routes/auth_guard.dart';
import 'package:myapp/screens/home.dart';

@MaterialAutoRouter(replaceInRouteName: "Page,Router", routes: <AutoRoute>[
  AutoRoute(
    path: '/session',
    page: HomeScreen,
    guards: [AuthGuard],
  ),
  AutoRoute(
    path: '/launch',
    page: AppWrapper,
    initial: true,
  )
])
class $AppRouter {}
