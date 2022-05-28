part of 'found_trips_bloc.dart';

abstract class FoundTripsState extends Equatable {
  const FoundTripsState();

  @override
  List<Object> get props => [];
}

class FoundTripsInitial extends FoundTripsState {}

class Loading extends FoundTripsState {}

class FoundTripsLoaded extends FoundTripsState {
  final List<FoundTrip> data;
  const FoundTripsLoaded({required this.data});
}

class FoundTripsError extends FoundTripsState {
  final String message;
  const FoundTripsError({required this.message});
}
