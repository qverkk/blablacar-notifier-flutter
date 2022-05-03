import 'package:auto_route/auto_route.dart';
import 'package:myapp/routes/app_router.gr.dart';
import 'package:myapp/storage.dart';

class AuthGuard extends AutoRouteGuard {
  final SecureStorage storage;

  AuthGuard(this.storage);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (await storage.hasToken()) {
      resolver.next(true);
    } else {
      router.push(const AppWrapper());
    }
  }
}
