import 'package:intl/intl.dart';

class TripDetails {
  final String? id;
  final String fromCity;
  final String toCity;
  final DateTime startDate;
  final DateTime endDate;
  final String userRegistrationToken;

  const TripDetails({
    this.id,
    required this.fromCity,
    required this.toCity,
    required this.startDate,
    required this.endDate,
    required this.userRegistrationToken,
  });

  factory TripDetails.fromJson(Map<String, dynamic> json) {
    return TripDetails(
      id: json['_id'] as String,
      fromCity: json['fromCity'] as String,
      toCity: json['toCity'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      userRegistrationToken: json['userRegistrationToken'] as String,
    );
  }

  Map toJson() => {
        '_id': id,
        'fromCity': fromCity,
        'toCity': toCity,
        'startDate': DateFormat('yyyy-MM-dd').format(startDate),
        'endDate': DateFormat('yyyy-MM-dd').format(endDate),
        'userRegistrationToken': userRegistrationToken,
      };
}
