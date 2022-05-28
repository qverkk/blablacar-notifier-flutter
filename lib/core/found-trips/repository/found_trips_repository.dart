import 'package:myapp/core/found-trips/models/found_trips.dart';
import 'package:myapp/core/found-trips/service/found_trips_service.dart';

class FoundTripsRepository {
  FoundTripsRepository({required this.service});

  FoundTripsService service;

  @override
  Future<List<FoundTrip>> getAll(String sessionToken) =>
      service.fetchFoundTrips(sessionToken);

  Future<bool> notifyAgain(String tripId, String sessionToken) =>
      service.notifyAgain(tripId, sessionToken);
}
