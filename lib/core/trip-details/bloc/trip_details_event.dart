part of 'trip_details_bloc.dart';

abstract class TripDetailsEvent extends Equatable {
  const TripDetailsEvent();

  @override
  List<Object> get props => [];
}

class InitTripDetails extends TripDetailsEvent {}

class OpenNewTripDetailsScreen extends TripDetailsEvent {}

class ViewFoundTrips extends TripDetailsEvent {
  final String requestTripId;
  final String title;

  const ViewFoundTrips(this.requestTripId, this.title);

  @override
  List<Object> get props => [requestTripId, title];
}

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
