import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/core/auth/bloc/auth_bloc.dart';
import 'package:myapp/routes/app_router.gr.dart';
import 'package:myapp/routes/auth_guard.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:myapp/storage.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  final secureStorage = SecureStorage();
  final authService = AuthService();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(
          secureStorage: secureStorage,
          authService: authService,
        )..add(StartApp()),
      ),
    ],
    child: MyApp(router: AppRouter(authGuard: AuthGuard(secureStorage))),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.router}) : super(key: key);

  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
      theme: ThemeData.dark(),
    );
  }
}
