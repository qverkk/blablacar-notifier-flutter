part of 'found_trips_bloc.dart';

abstract class FoundTripsEvent extends Equatable {
  const FoundTripsEvent();

  @override
  List<Object> get props => [];
}

class InitFoundTrips extends FoundTripsEvent {
  final String requestTripId;

  const InitFoundTrips(this.requestTripId);

  @override
  List<Object> get props => [requestTripId];
}

class NotifyAgainEvent extends FoundTripsEvent {
  final String tripId;
  final String requestTripId;

  const NotifyAgainEvent(this.tripId, this.requestTripId);

  @override
  List<Object> get props => [tripId, requestTripId];
}

class NotifyAllAgainEvent extends FoundTripsEvent {
  final String requestTripId;

  const NotifyAllAgainEvent(this.requestTripId);

  @override
  List<Object> get props => [requestTripId];
}
