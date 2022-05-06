// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../app.dart' as _i1;
import '../core/trip-details/screens/trip_details_screen.dart' as _i4;
import '../screens/home.dart' as _i3;
import '../screens/home_page.dart' as _i2;
import 'auth_guard.dart' as _i7;

class AppRouter extends _i5.RootStackRouter {
  AppRouter(
      {_i6.GlobalKey<_i6.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i7.AuthGuard authGuard;

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    AppWrapper.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.AppWrapper());
    },
    HomeRouter.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.HomePage());
    },
    HomeScreenRouter.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.HomeScreen());
    },
    TripDetailsRouter.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.TripDetailsScreen());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig('/#redirect',
            path: '/', redirectTo: '/login', fullMatch: true),
        _i5.RouteConfig(AppWrapper.name, path: '/login'),
        _i5.RouteConfig(HomeRouter.name, path: '/home', guards: [
          authGuard
        ], children: [
          _i5.RouteConfig(HomeScreenRouter.name,
              path: '', parent: HomeRouter.name),
          _i5.RouteConfig(TripDetailsRouter.name,
              path: 'trip-details', parent: HomeRouter.name)
        ])
      ];
}

/// generated route for
/// [_i1.AppWrapper]
class AppWrapper extends _i5.PageRouteInfo<void> {
  const AppWrapper() : super(AppWrapper.name, path: '/login');

  static const String name = 'AppWrapper';
}

/// generated route for
/// [_i2.HomePage]
class HomeRouter extends _i5.PageRouteInfo<void> {
  const HomeRouter({List<_i5.PageRouteInfo>? children})
      : super(HomeRouter.name, path: '/home', initialChildren: children);

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i3.HomeScreen]
class HomeScreenRouter extends _i5.PageRouteInfo<void> {
  const HomeScreenRouter() : super(HomeScreenRouter.name, path: '');

  static const String name = 'HomeScreenRouter';
}

/// generated route for
/// [_i4.TripDetailsScreen]
class TripDetailsRouter extends _i5.PageRouteInfo<void> {
  const TripDetailsRouter()
      : super(TripDetailsRouter.name, path: 'trip-details');

  static const String name = 'TripDetailsRouter';
}
