import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:myapp/core/trip-details/models/trip_details.dart';

class TripDetailsService {
  Future<List<TripDetails>> fetchTripDetails(String sessionToken) async {
    final Dio client = Dio();
    try {
      var response = await client.get('http://192.168.0.199:8080/trip-details',
          options: Options(headers: {
            "kratos-session": sessionToken,
          }));
      return parseTripDetails(response.data);
    } finally {
      client.close();
    }
  }

  List<TripDetails> parseTripDetails(List responseBody) {
    return responseBody.map((value) => TripDetails.fromJson(value)).toList();
  }

  Future<bool> saveTripDetails(
    TripDetails tripDetails,
    String sessionToken,
  ) async {
    final Dio client = Dio();
    try {
      var response = await client.post(
        'http://192.168.0.199:8080/trip-details',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "kratos-session": sessionToken,
          },
        ),
        data: jsonEncode(tripDetails),
      );

      return response.statusCode == 201;
    } catch (_) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<num> countFoundTrips(String tripRequestId, String sessionToken) async {
    final Dio client = Dio();
    try {
      var response = await client.get(
        'http://192.168.0.199:8080/trip-details/$tripRequestId/found-trips/count',
        options: Options(
          headers: {
            "kratos-session": sessionToken,
          },
        ),
      );

      return response.data;
    } catch (_) {
      return 0;
    } finally {
      client.close();
    }
  }

  Future<void> deleteById(String id, String sessionToken) async {
    final Dio client = Dio();
    try {
      await client.delete(
        'http://192.168.0.199:8080/trip-details/$id',
        options: Options(
          headers: {
            "kratos-session": sessionToken,
          },
        ),
      );
    } catch (_) {
    } finally {
      client.close();
    }
  }
}
