import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/core/auth/bloc/auth_bloc.dart';
import 'package:myapp/core/found-trips/models/found_trips.dart';
import 'package:myapp/core/found-trips/repository/found_trips_repository.dart';

part 'found_trips_event.dart';
part 'found_trips_state.dart';

class FoundTripsBloc extends Bloc<FoundTripsEvent, FoundTripsState> {
  final FoundTripsRepository repository;
  final AuthBloc authBloc;

  FoundTripsBloc({required this.repository, required this.authBloc})
      : super(FoundTripsInitial()) {
    on<InitFoundTrips>(_initFoundTrips);
    on<NotifyAgainEvent>(_notifyAgain);
  }

  FutureOr<void> _initFoundTrips(
    InitFoundTrips event,
    Emitter<FoundTripsState> emit,
  ) async {
    final authState = authBloc.state as AuthAuthenticated;
    emit.call(Loading());
    try {
      var foundTrips = await repository.getFoundTripsForRequestedTrip(
          event.requestTripId, authState.token);
      emit.call(FoundTripsLoaded(data: foundTrips));
    } on DioError catch (e) {
      emit.call(FoundTripsError(message: e.message));
    }
  }

  FutureOr<void> _notifyAgain(
    NotifyAgainEvent event,
    Emitter<FoundTripsState> emit,
  ) async {
    final authState = authBloc.state as AuthAuthenticated;
    emit.call(Loading());
    try {
      await repository.notifyAgain(event.tripId, authState.token);
      add(InitFoundTrips(event.requestTripId));
    } on DioError catch (e) {
      emit.call(FoundTripsError(message: e.message));
    }
  }
}
