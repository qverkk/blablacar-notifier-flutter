import 'package:myapp/core/found-trips/models/found_trips.dart';
import 'package:myapp/core/found-trips/service/found_trips_service.dart';

class FoundTripsRepository {
  FoundTripsRepository({required this.service});

  FoundTripsService service;

  Future<List<FoundTrip>> getAllFoundTrips(String sessionToken) =>
      service.fetchFoundTrips(sessionToken);

  Future<bool> notifyAgain(String tripId, String sessionToken) =>
      service.notifyAgain(tripId, sessionToken);

  Future<List<FoundTrip>> getFoundTripsForRequestedTrip(
          String requestTripId, String sessionToken) =>
      service.getFoundTripsForRequestedTrip(requestTripId, sessionToken);
}
