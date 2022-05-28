import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/core/auth/bloc/auth_bloc.dart';
import 'package:myapp/core/notifications/notifications.dart';
import 'package:myapp/routes/app_router.gr.dart';
import 'package:myapp/routes/auth_guard.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:myapp/storage.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Notifications.showNotification(
    title:
        'Found ${message.data['numberOfNewTrips']} new trips! Check them out!',
  );
}

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  final secureStorage = SecureStorage();
  final authService = AuthService();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((event) {
    Notifications.showNotification(
      title:
          'Found ${event.data['numberOfNewTrips']} new trips! Check them out!',
    );
  });

  Notifications.init();

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
