class FoundTrip {
  final String id;
  final String blablacarTripId;
  final String blablacarSource;
  final bool notified;
  final bool notifyFreeSeats;
  final String price;
  final num remainingSeats;
  final num maxSeats;
  final String userRegisteredToken;
  final String userId;
  final num driverRating;
  final String driverDisplayName;
  final num driverRatingsCount;
  final String driverStatusCode;
  final String? driverStatusLabel;
  final String fromCityDepartureTime;
  final String toCityDepartureTime;
  final num fromCityDistance;
  final String fromCityProximity;
  final num toCityDistance;
  final String toCityProximity;

  const FoundTrip({
    required this.id,
    required this.blablacarTripId,
    required this.blablacarSource,
    required this.notified,
    required this.notifyFreeSeats,
    required this.price,
    required this.remainingSeats,
    required this.maxSeats,
    required this.userRegisteredToken,
    required this.userId,
    required this.driverRating,
    required this.driverDisplayName,
    required this.driverRatingsCount,
    required this.driverStatusCode,
    required this.driverStatusLabel,
    required this.fromCityDepartureTime,
    required this.toCityDepartureTime,
    required this.fromCityDistance,
    required this.fromCityProximity,
    required this.toCityDistance,
    required this.toCityProximity,
  });

  factory FoundTrip.fromJson(Map<String, dynamic> json) {
    return FoundTrip(
      id: json['_id'] as String,
      blablacarTripId: json['blablacarTripId'] as String,
      blablacarSource: json['blablacarSource'] as String,
      notified: json['notified'] as bool,
      notifyFreeSeats: json['notifyFreeSeats'] as bool,
      price: json['price'] as String,
      remainingSeats: json['remainingSeats'] as num? ?? 0,
      maxSeats: json['maxSeats'] as num? ?? 0,
      userRegisteredToken: json['userRegisteredToken'] as String,
      userId: json['userId'] as String,
      driverRating: json['driverRating'] as num? ?? 0,
      driverDisplayName: json['driverDisplayName'] as String,
      driverRatingsCount: json['driverRatingsCount'] as num? ?? 0,
      driverStatusCode: json['driverStatusCode'] as String,
      driverStatusLabel: json['driverStatusLabel'] as String?,
      fromCityDepartureTime: json['fromCityDepartureTime'] as String,
      toCityDepartureTime: json['toCityDepartureTime'] as String,
      fromCityDistance: json['fromCityDistance'] as num? ?? 0,
      fromCityProximity: json['fromCityProximity'] as String,
      toCityDistance: json['toCityDistance'] as num? ?? 0,
      toCityProximity: json['toCityProximity'] as String,
    );
  }
}
