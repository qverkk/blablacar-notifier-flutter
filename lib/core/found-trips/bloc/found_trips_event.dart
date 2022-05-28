part of 'found_trips_bloc.dart';

abstract class FoundTripsEvent extends Equatable {
  const FoundTripsEvent();

  @override
  List<Object> get props => [];
}

class InitFoundTrips extends FoundTripsEvent {}

class NotifyAgainEvent extends FoundTripsEvent {
  final String tripId;

  const NotifyAgainEvent(this.tripId);

  @override
  List<Object> get props => [tripId];
}
