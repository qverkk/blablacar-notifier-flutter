part of 'trip_details_bloc.dart';

abstract class TripDetailsEvent extends Equatable {
  const TripDetailsEvent();

  @override
  List<Object> get props => [];
}

class InitTripDetails extends TripDetailsEvent {}

class RefreshTripDetails extends TripDetailsEvent {}

class LoadTripDetailsEvent extends TripDetailsEvent {
  final List<TripDetails> tripDetails;

  const LoadTripDetailsEvent(this.tripDetails);

  @override
  List<Object> get props => [tripDetails];
}
