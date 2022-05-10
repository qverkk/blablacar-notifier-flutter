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

class OpenNewTripDetailsScreen extends TripDetailsEvent {}

class AddNewTripDetails extends TripDetailsEvent {
  final TripDetails tripDetails;

  const AddNewTripDetails(this.tripDetails);

  @override
  List<Object> get props => [tripDetails];
}

class DeleteTripDetailsEvent extends TripDetailsEvent {
  final String id;

  const DeleteTripDetailsEvent(this.id);

  @override
  List<Object> get props => [id];
}
