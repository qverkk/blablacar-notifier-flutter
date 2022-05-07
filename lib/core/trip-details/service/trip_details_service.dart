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
}
