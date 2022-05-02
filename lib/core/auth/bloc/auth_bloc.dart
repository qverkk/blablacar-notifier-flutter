import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapp/exceptions.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:myapp/storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SecureStorage secureStorage;
  final AuthService authService;

  AuthBloc({required this.secureStorage, required this.authService})
      : super(const AuthUninitialized()) {
    on<StartApp>(_startApp);
    on<InitLoginFlow>(_initLoginFlow);
    on<InitRegistrationFlow>(_initRegistrationFlow);
    on<ChangeField>(_changeField);
    on<SignIn>(_signIn);
    on<SignUp>(_signUp);
    on<SignOut>(_signOut);
  }

  void _startApp(StartApp event, Emitter<AuthState> emit) async {
    try {
      if (await secureStorage.hasToken()) {
        final sessionToken = await secureStorage.getToken();
        await getCurrentSession(sessionToken!, emit);
      } else {
        emit.call(const AuthUnauthenticated());
      }
    } on UnauthorizedException catch (_) {
      await secureStorage.deleteToken();
      emit.call(const AuthUnauthenticated());
    } on UnknownException catch (e) {
      emit.call(AuthUninitialized(e.message));
    } catch (e) {
      emit.call(
        const AuthUninitialized('An error occured. Please try again late.'),
      );
    }
  }

  void _initLoginFlow(InitLoginFlow event, Emitter<AuthState> emit) async {
    final currentState = state;
    try {
      emit.call(AuthLoading());

      final flowId = await authService.initiateLoginFlow();

      emit.call(AuthLoginInitialized(flowId: flowId));
    } on UnknownException catch (e) {
      if (currentState is AuthRegistrationInitialized) {
        emit.call(
          AuthRegistrationInitialized(
            flowId: currentState.flowId,
            email: currentState.email,
            password: currentState.password,
            message: "An error occured. Try again later.",
          ),
        );
      } else {
        emit.call(
          AuthUninitialized(e.message),
        );
      }
    } catch (e) {
      if (currentState is AuthRegistrationInitialized) {
        emit.call(
          AuthRegistrationInitialized(
            flowId: currentState.flowId,
            email: currentState.email,
            password: currentState.password,
            message: "An error occured. Try again later.",
          ),
        );
      } else {
        emit.call(
          const AuthUninitialized("An error occured. Try again later."),
        );
      }
    }
  }

  void _initRegistrationFlow(
      InitRegistrationFlow event, Emitter<AuthState> emit) async {
    try {
      emit.call(AuthLoading());

      final flowId = await authService.intiateRegistrationFlow();

      emit.call(AuthRegistrationInitialized(flowId: flowId));
    } on UnknownException catch (e) {
      final currentState = state as AuthLoginInitialized;
      emit.call(AuthLoginInitialized(
          flowId: currentState.flowId,
          email: currentState.email,
          password: currentState.password,
          message: e.message));
    } catch (_) {
      final currentState = state as AuthLoginInitialized;
      emit.call(AuthLoginInitialized(
          flowId: currentState.flowId,
          email: currentState.email,
          password: currentState.password,
          message: "An error occured. Try again later."));
    }
  }

  void _changeField(ChangeField event, Emitter<AuthState> emit) {
    if (state is AuthRegistrationInitialized) {
      final currentState = state as AuthRegistrationInitialized;
      emit.call(event.field == "password"
          ? AuthRegistrationInitialized(
              flowId: currentState.flowId,
              email: currentState.email,
              emailError: currentState.emailError,
              password: event.value)
          : AuthRegistrationInitialized(
              flowId: currentState.flowId,
              email: event.value,
              password: currentState.password,
              passwordError: currentState.passwordError));
    } else {
      final currentState = state as AuthLoginInitialized;
      emit.call(event.field == "password"
          ? AuthLoginInitialized(
              flowId: currentState.flowId,
              email: currentState.email,
              emailError: currentState.emailError,
              password: event.value)
          : AuthLoginInitialized(
              flowId: currentState.flowId,
              email: event.value,
              password: currentState.password,
              passwordError: currentState.passwordError));
    }
  }

  void _signIn(SignIn event, Emitter<AuthState> emit) async {
    try {
      emit.call(AuthLoading());
      final sessionToken =
          await authService.signIn(event.flowId, event.email, event.password);
      await secureStorage.persistToken(sessionToken);
      await getCurrentSession(sessionToken, emit);
    } on InvalidCredentialsException catch (e) {
      emit.call(AuthLoginInitialized(
          flowId: event.flowId,
          email: event.email,
          emailError: e.errors["traits.email"] ?? "",
          password: event.password,
          passwordError: e.errors["password"] ?? "",
          generalError: e.errors["general"] ?? ""));
    } on UnknownException catch (e) {
      emit.call(AuthLoginInitialized(
          flowId: event.flowId,
          email: event.email,
          password: event.password,
          message: e.message));
    } on UnauthorizedException catch (_) {
      await secureStorage.deleteToken();
      emit.call(
          const AuthUnauthenticated("Your session expired. Please sign in."));
    } catch (_) {
      emit.call(AuthLoginInitialized(
          flowId: event.flowId,
          email: event.email,
          password: event.password,
          message: "An error occured. Please try again later."));
    }
  }

  void _signUp(SignUp event, Emitter<AuthState> emit) async {
    try {
      emit.call(AuthLoading());

      final sessionToken =
          await authService.signUp(event.flowId, event.email, event.password);
      await secureStorage.persistToken(sessionToken);
      await getCurrentSession(sessionToken, emit);
    } on InvalidCredentialsException catch (e) {
      emit.call(AuthRegistrationInitialized(
          //save auth errors
          flowId: event.flowId,
          email: event.email,
          emailError: e.errors["traits.email"] ?? "",
          password: event.password,
          passwordError: e.errors["password"] ?? "",
          generalError: e.errors["general"] ?? ""));
    } on UnauthorizedException catch (_) {
      await secureStorage.deleteToken();
      emit.call(const AuthUnauthenticated(
          "Your session expired. Please sign in.")); //navigate to sign in page when session token invalid
    } on UnknownException catch (e) {
      emit.call(AuthLoginInitialized(
          flowId: event.flowId,
          email: event.email,
          password: event.password,
          message: e.message));
    } catch (e) {
      emit.call(AuthRegistrationInitialized(
          flowId: event.flowId,
          email: event.email,
          password: event.password,
          message: "An error occured. Please try again later."));
    }
  }

  void _signOut(SignOut event, Emitter<AuthState> emit) async {
    final currentState = state as AuthAuthenticated;
    try {
      emit.call(AuthLoading());
      await authService.signOut();
      emit.call(const AuthUnauthenticated());
    } on UnknownException catch (e) {
      emit.call(
        AuthAuthenticated(
          email: currentState.email,
          id: currentState.id,
          token: currentState.token,
          message: e.message,
        ),
      );
    } catch (_) {
      emit.call(
        AuthAuthenticated(
          email: currentState.email,
          id: currentState.id,
          token: currentState.token,
          message: "An error occured. Please try again later.",
        ),
      );
    }
  }

  Future<void> getCurrentSession(
    String token,
    Emitter<AuthState> emit,
  ) async {
    try {
      await emit.forEach(
          Stream.fromFuture(
            authService.getCurrentSession(token),
          ), onData: (value) {
        var result = value as Map;
        return AuthAuthenticated(
          email: result['email'],
          id: result['id'],
          token: token,
        );
      });
    } on UnknownException catch (e) {
      emit.call(
        AuthAuthenticated(
          email: "",
          id: "",
          token: token,
          message: e.message,
        ),
      );
    } on UnauthorizedException catch (_) {
      await secureStorage.deleteToken();
      emit.call(
        const AuthUnauthenticated(
          "Your session expired. Please isgn in.",
        ),
      );
    } on Exception catch (_) {
      emit.call(
        AuthAuthenticated(
          email: "",
          id: "",
          token: token,
          message:
              "An error occured while retrieving information. Please try again later.",
        ),
      );
    }
  }
}
