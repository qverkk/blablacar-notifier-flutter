class FoundTrip {
  final String id;
  final String blablacarTripId;
  final String blablacarSource;
  final bool notified;
  final bool notifyFreeSeats;
  final String price;
  final num remainingSeats;
  final String userRegisteredToken;
  final String userId;
  final num driverRating;
  final String driverDisplayName;
  final num driverRatingsCount;
  final String driverStatusCode;
  final String? driverStatusLabel;
  final String fromCityDepartureTime;
  final String toCityDepartureTime;

  const FoundTrip({
    required this.id,
    required this.blablacarTripId,
    required this.blablacarSource,
    required this.notified,
    required this.notifyFreeSeats,
    required this.price,
    required this.remainingSeats,
    required this.userRegisteredToken,
    required this.userId,
    required this.driverRating,
    required this.driverDisplayName,
    required this.driverRatingsCount,
    required this.driverStatusCode,
    required this.driverStatusLabel,
    required this.fromCityDepartureTime,
    required this.toCityDepartureTime,
  });

  factory FoundTrip.fromJson(Map<String, dynamic> json) {
    return FoundTrip(
      id: json['_id'] as String,
      blablacarTripId: json['blablacarTripId'] as String,
      blablacarSource: json['blablacarSource'] as String,
      notified: json['notified'] as bool,
      notifyFreeSeats: json['notifyFreeSeats'] as bool,
      price: json['price'] as String,
      remainingSeats: json['remainingSeats'] as num,
      userRegisteredToken: json['userRegisteredToken'] as String,
      userId: json['userId'] as String,
      driverRating: json['driverRating'] as num,
      driverDisplayName: json['driverDisplayName'] as String,
      driverRatingsCount: json['driverRatingsCount'] as num,
      driverStatusCode: json['driverStatusCode'] as String,
      driverStatusLabel: json['driverStatusLabel'] as String?,
      fromCityDepartureTime: json['fromCityDepartureTime'] as String,
      toCityDepartureTime: json['toCityDepartureTime'] as String,
    );
  }
}
