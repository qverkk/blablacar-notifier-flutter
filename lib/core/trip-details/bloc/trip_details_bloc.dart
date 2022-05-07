import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/auth/bloc/auth_bloc.dart';
import 'package:myapp/core/trip-details/models/trip_details.dart';
import 'package:myapp/core/trip-details/repository/trip_details_repository.dart';

part 'trip_details_event.dart';
part 'trip_details_state.dart';

class TripDetailsBloc extends Bloc<TripDetailsEvent, TripDetailsState> {
  final TripDetailsRepository repository;
  final AuthBloc authBloc;

  TripDetailsBloc({required this.repository, required this.authBloc})
      : super(Loading()) {
    on<InitTripDetails>(_initTripDetails);
  }

  FutureOr<void> _initTripDetails(
    InitTripDetails event,
    Emitter<TripDetailsState> emit,
  ) async {
    final authState = authBloc.state as AuthAuthenticated;
    emit.call(Loading());
    try {
      var tripDetails = await repository.getAll(authState.token);
      emit.call(TripDetailsLoaded(data: tripDetails));
    } on DioError catch (e) {
      emit.call(TripDetailsError(message: e.message));
    }
  }
}
