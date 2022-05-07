import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/trip-details/models/trip_details.dart';

part 'trip_details_event.dart';
part 'trip_details_state.dart';

class TripDetailsBloc extends Bloc<TripDetailsEvent, TripDetailsState> {
  TripDetailsBloc() : super(Initial()) {
    on<InitTripDetails>(_initTripDetails);
  }

  FutureOr<void> _initTripDetails(
    InitTripDetails event,
    Emitter<TripDetailsState> emit,
  ) {}
}
