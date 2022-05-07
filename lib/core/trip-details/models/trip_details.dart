import 'package:intl/intl.dart';

class TripDetails {
  final String fromCity;
  final String toCity;
  final DateTime startDate;
  final DateTime endDate;

  const TripDetails({
    required this.fromCity,
    required this.toCity,
    required this.startDate,
    required this.endDate,
  });

  factory TripDetails.fromJson(Map<String, dynamic> json) {
    return TripDetails(
      fromCity: json['fromCity'] as String,
      toCity: json['toCity'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );
  }

  Map toJson() => {
        'fromCity': fromCity,
        'toCity': toCity,
        'startDate': DateFormat('yyyy-MM-dd').format(startDate),
        'endDate': DateFormat('yyyy-MM-dd').format(endDate),
      };
}
