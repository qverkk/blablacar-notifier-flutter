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
    on<OpenNewTripDetailsScreen>(_openNewTripDetailsScreen);
    on<AddNewTripDetails>(_addNewTripDetails);
    on<DeleteTripDetailsEvent>(_deleteTripDetails);
  }

  FutureOr<void> _initTripDetails(
    InitTripDetails event,
    Emitter<TripDetailsState> emit,
  ) async {
    final authState = authBloc.state as AuthAuthenticated;
    emit.call(Loading());
    try {
      var tripDetails = await repository.getAll(authState.token);
      for (var element in tripDetails) {
        element.foundTrips =
            await repository.getTripsFound(element.id!, authState.token);
      }
      emit.call(TripDetailsLoaded(data: tripDetails));
    } on DioError catch (e) {
      emit.call(TripDetailsError(message: e.message));
    }
  }

  FutureOr<void> _openNewTripDetailsScreen(
    OpenNewTripDetailsScreen event,
    Emitter<TripDetailsState> emit,
  ) {
    emit.call(AddingTripDetails());
  }

  FutureOr<void> _addNewTripDetails(
    AddNewTripDetails event,
    Emitter<TripDetailsState> emit,
  ) async {
    final authState = authBloc.state as AuthAuthenticated;
    emit.call(Loading());
    var success = await repository.save(
      event.tripDetails,
      authState.token,
    );

    if (success) {
      add(InitTripDetails());
    } else {
      add(OpenNewTripDetailsScreen());
    }
  }

  Future<FutureOr<void>> _deleteTripDetails(
    DeleteTripDetailsEvent event,
    Emitter<TripDetailsState> emit,
  ) async {
    final authState = authBloc.state as AuthAuthenticated;
    emit.call(Loading());
    await repository.deleteById(
      event.id,
      authState.token,
    );
    add(InitTripDetails());
  }
}
