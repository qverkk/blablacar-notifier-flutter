import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/auth/bloc/auth_bloc.dart';
import 'package:myapp/routes/app_router.gr.dart';
import 'package:myapp/storage.dart';

class AuthGuard extends AutoRouteGuard {
  final SecureStorage storage;

  AuthGuard(this.storage);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // var context = router.navigatorKey.currentContext!;
    // final authBloc = BlocProvider.of<AuthBloc>(context);
    // print("Current bloc: ${authBloc is AuthAuthenticated}");
    // if (authBloc is AuthAuthenticated) {
    resolver.next(true);
    // } else {
    //   router.push(const AppWrapper());
    // }
  }
}
