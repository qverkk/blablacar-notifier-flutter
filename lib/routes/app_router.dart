import 'package:auto_route/auto_route.dart';
import 'package:myapp/app.dart';
import 'package:myapp/core/found-trips/screens/found_trips_screen.dart';
import 'package:myapp/core/trip-details/screens/trip_details_screen.dart';
import 'package:myapp/routes/auth_guard.dart';
import 'package:myapp/screens/session_information.dart';
import 'package:myapp/screens/home_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: "Page,Router",
  routes: <AutoRoute>[
    AutoRoute(
      path: "/login",
      page: AppWrapper,
      initial: true,
    ),
    AutoRoute(
      path: '/home',
      page: HomePage,
      guards: [AuthGuard],
      children: [
        AutoRoute(
          path: '',
          name: 'HomeScreenRouter',
          page: SessionInformationScreen,
          // initial: true,
        ),
        AutoRoute(
          path: 'trip-details',
          name: 'TripDetailsRouter',
          page: TripDetailsScreen,
        ),
        AutoRoute(
          path: 'found-trips',
          name: 'FoundTripsRouter',
          page: FoundTripsScreen,
        )
      ],
    )
  ],
)
class $AppRouter {}
