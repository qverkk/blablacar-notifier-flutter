import 'package:myapp/core/trip-details/models/trip_details.dart';
import 'package:myapp/core/trip-details/service/trip_details_service.dart';

class TripDetailsRepository {
  TripDetailsRepository({required this.service});

  TripDetailsService service;

  @override
  Future<List<TripDetails>> getAll(String sessionToken) =>
      service.fetchTripDetails(sessionToken);

  Future<bool> save(TripDetails tripDetails, String sessionToken) =>
      service.saveTripDetails(tripDetails, sessionToken);
}
