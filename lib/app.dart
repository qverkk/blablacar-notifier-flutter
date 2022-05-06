import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/auth/bloc/auth_bloc.dart';
import 'package:myapp/core/auth/screens/sign_in.dart';
import 'package:myapp/core/auth/screens/sign_up.dart';
import 'package:myapp/routes/app_router.gr.dart';
import 'package:myapp/screens/auth_fallback_page.dart';

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
        if (state is AuthUninitialized) {
          return const AuthFallbackPage();
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
          var router = AutoRouter.of(context);
          router.push(const HomeRouter());
        }

        return const AuthFallbackPage();
      },
    );
  }
}
