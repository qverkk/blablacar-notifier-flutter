import 'package:dio/dio.dart';
import 'package:myapp/core/found-trips/models/found_trips.dart';

class FoundTripsService {
  Future<List<FoundTrip>> fetchFoundTrips(String sessionToken) async {
    final Dio client = Dio();
    try {
      var response = await client.get('http://192.168.0.199:8080/trips-found',
          options: Options(headers: {
            "kratos-session": sessionToken,
          }));
      return parseTripsFound(response.data);
    } finally {
      client.close();
    }
  }

  Future<List<FoundTrip>> getFoundTripsForRequestedTrip(
      String requestTripId, String sessionToken) async {
    final Dio client = Dio();
    try {
      var response = await client.get(
        'http://192.168.0.199:8080/trip-details/$requestTripId/found-trips',
        options: Options(
          headers: {
            "kratos-session": sessionToken,
          },
        ),
      );

      return parseTripsFound(response.data);
    } finally {
      client.close();
    }
  }

  List<FoundTrip> parseTripsFound(List responseBody) {
    return responseBody.map((value) => FoundTrip.fromJson(value)).toList();
  }

  Future<bool> notifyAgain(
    String foundTripId,
    String sessionToken,
  ) async {
    final Dio client = Dio();
    try {
      var response = await client.patch(
        'http://192.168.0.199:8080/trips-found/$foundTripId/notify',
        options: Options(
          headers: {
            "kratos-session": sessionToken,
          },
        ),
      );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> notifyAllAgain(
    String requestTripId,
    String sessionToken,
  ) async {
    final Dio client = Dio();
    try {
      var response = await client.patch(
        'http://192.168.0.199:8080/trip-details/$requestTripId/found-trips/notify',
        options: Options(
          headers: {
            "kratos-session": sessionToken,
          },
        ),
      );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
