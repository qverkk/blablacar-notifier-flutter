import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/auth/bloc/auth_bloc.dart';
import 'package:myapp/core/auth/screens/sign_in.dart';
import 'package:myapp/core/auth/screens/sign_up.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/screens/launch.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is! AuthUnauthenticated) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message!),
            ));
          }
        }
      },
      builder: (context, state) {
        print(state);
        if (state is AuthUninitialized) {
          return const LaunchScreen();
        } else if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is AuthUnauthenticated) {
          final authBloc = BlocProvider.of<AuthBloc>(context);
          authBloc.add(InitLoginFlow());
        } else if (state is AuthRegistrationInitialized) {
          return const SignUpScreen();
        } else if (state is AuthLoginInitialized) {
          return const SignInScreen();
        } else if (state is AuthAuthenticated) {
          return const HomeScreen();
        }

        return const LaunchScreen();
      },
    );
  }
}
