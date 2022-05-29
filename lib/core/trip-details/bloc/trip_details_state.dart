part of 'trip_details_bloc.dart';

@immutable
abstract class TripDetailsState extends Equatable {
  const TripDetailsState();

  @override
  List<Object> get props => [];
}

class LoadingTripDetails extends TripDetailsState {}

class AddingTripDetails extends TripDetailsState {}

class ViewingFoundTrips extends TripDetailsState {
  final String requestTripId;
  final String title;
  const ViewingFoundTrips(this.requestTripId, this.title);
}

class TripDetailsLoaded extends TripDetailsState {
  final List<TripDetails> data;
  const TripDetailsLoaded({required this.data});
}

class TripDetailsError extends TripDetailsState {
  final String message;
  const TripDetailsError({required this.message});
}
