import 'package:myapp/core/trip-details/models/trip_details.dart';
import 'package:myapp/core/trip-details/service/trip_details_service.dart';

class TripDetailsRepository {
  TripDetailsRepository({required this.service});

  TripDetailsService service;

  Future<List<TripDetails>> getAllTripDetails(String sessionToken) =>
      service.fetchTripDetails(sessionToken);

  Future<num> getTripsFoundCount(String tripRequestId, String sessionToken) =>
      service.countFoundTrips(tripRequestId, sessionToken);

  Future<bool> save(TripDetails tripDetails, String sessionToken) =>
      service.saveTripDetails(tripDetails, sessionToken);

  Future<void> deleteById(String id, String sessionToken) =>
      service.deleteById(id, sessionToken);
}
