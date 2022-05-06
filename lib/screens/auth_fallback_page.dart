import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/auth/bloc/auth_bloc.dart';

class AuthFallbackPage extends StatelessWidget {
  const AuthFallbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final authState = authBloc.state;
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            if (authState.message != null && authState is AuthUninitialized)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  authState.message!,
                ),
              )
          ],
        ),
      ),
    );
  }
}
