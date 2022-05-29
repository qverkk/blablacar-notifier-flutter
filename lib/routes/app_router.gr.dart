// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../app.dart' as _i1;
import '../core/found-trips/screens/found_trips_screen.dart' as _i5;
import '../core/trip-details/screens/trip_details_screen.dart' as _i4;
import '../screens/home_page.dart' as _i2;
import '../screens/session_information.dart' as _i3;
import 'auth_guard.dart' as _i8;

class AppRouter extends _i6.RootStackRouter {
  AppRouter(
      {_i7.GlobalKey<_i7.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i8.AuthGuard authGuard;

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    AppWrapper.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.AppWrapper());
    },
    HomeRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.HomePage());
    },
    HomeScreenRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.SessionInformationScreen());
    },
    TripDetailsRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.TripDetailsScreen());
    },
    FoundTripsRouter.name: (routeData) {
      final args = routeData.argsAs<FoundTripsRouterArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.FoundTripsScreen(
              key: args.key,
              requestTripId: args.requestTripId,
              title: args.title));
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig('/#redirect',
            path: '/', redirectTo: '/login', fullMatch: true),
        _i6.RouteConfig(AppWrapper.name, path: '/login'),
        _i6.RouteConfig(HomeRouter.name, path: '/home', guards: [
          authGuard
        ], children: [
          _i6.RouteConfig(HomeScreenRouter.name,
              path: '', parent: HomeRouter.name),
          _i6.RouteConfig(TripDetailsRouter.name,
              path: 'trip-details', parent: HomeRouter.name),
          _i6.RouteConfig(FoundTripsRouter.name,
              path: 'found-trips', parent: HomeRouter.name)
        ])
      ];
}

/// generated route for
/// [_i1.AppWrapper]
class AppWrapper extends _i6.PageRouteInfo<void> {
  const AppWrapper() : super(AppWrapper.name, path: '/login');

  static const String name = 'AppWrapper';
}

/// generated route for
/// [_i2.HomePage]
class HomeRouter extends _i6.PageRouteInfo<void> {
  const HomeRouter({List<_i6.PageRouteInfo>? children})
      : super(HomeRouter.name, path: '/home', initialChildren: children);

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i3.SessionInformationScreen]
class HomeScreenRouter extends _i6.PageRouteInfo<void> {
  const HomeScreenRouter() : super(HomeScreenRouter.name, path: '');

  static const String name = 'HomeScreenRouter';
}

/// generated route for
/// [_i4.TripDetailsScreen]
class TripDetailsRouter extends _i6.PageRouteInfo<void> {
  const TripDetailsRouter()
      : super(TripDetailsRouter.name, path: 'trip-details');

  static const String name = 'TripDetailsRouter';
}

/// generated route for
/// [_i5.FoundTripsScreen]
class FoundTripsRouter extends _i6.PageRouteInfo<FoundTripsRouterArgs> {
  FoundTripsRouter(
      {_i7.Key? key, required String requestTripId, required String title})
      : super(FoundTripsRouter.name,
            path: 'found-trips',
            args: FoundTripsRouterArgs(
                key: key, requestTripId: requestTripId, title: title));

  static const String name = 'FoundTripsRouter';
}

class FoundTripsRouterArgs {
  const FoundTripsRouterArgs(
      {this.key, required this.requestTripId, required this.title});

  final _i7.Key? key;

  final String requestTripId;

  final String title;

  @override
  String toString() {
    return 'FoundTripsRouterArgs{key: $key, requestTripId: $requestTripId, title: $title}';
  }
}
