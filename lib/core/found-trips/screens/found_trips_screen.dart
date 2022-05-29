import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myapp/core/auth/bloc/auth_bloc.dart';
import 'package:myapp/core/found-trips/bloc/found_trips_bloc.dart';
import 'package:myapp/core/found-trips/models/found_trips.dart';
import 'package:myapp/core/found-trips/repository/found_trips_repository.dart';
import 'package:myapp/core/found-trips/service/found_trips_service.dart';
import 'package:myapp/core/trip-details/bloc/trip_details_bloc.dart';

class FoundTripsScreen extends StatelessWidget {
  final String requestTripId;
  final String title;

  const FoundTripsScreen(
      {Key? key, required this.requestTripId, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = FoundTripsService();
    final repository = FoundTripsRepository(service: service);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final bloc = FoundTripsBloc(
      repository: repository,
      authBloc: authBloc,
    )..add(InitFoundTrips(requestTripId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Found trips'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  var bloc = BlocProvider.of<TripDetailsBloc>(context);
                  bloc.add(InitTripDetails());
                });
          },
        ),
      ),
      body: RepositoryProvider(
        create: ((context) => repository),
        child: BlocProvider(
          create: ((context) => bloc),
          child: BlocConsumer<FoundTripsBloc, FoundTripsState>(
            listener: (context, state) => {},
            builder: (context, state) {
              if (state is Loading) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state is FoundTripsLoaded) {
                return RefreshIndicator(
                  child: Scaffold(
                    body: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            title,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) =>
                                _FoundTripsListItem(
                              item: state.data[index],
                              requestTripId: requestTripId,
                            ),
                            separatorBuilder: (context, index) => const Divider(
                              height: 20,
                            ),
                            itemCount: state.data.length,
                          ),
                        )
                      ],
                    ),
                  ),
                  onRefresh: () => Future.microtask(
                      () => bloc.add(InitFoundTrips(requestTripId))),
                );
              } else if (state is FoundTripsError) {
                return errorMessageWithRefreshButton(
                  bloc,
                  "Some error occured ${state.message}.",
                );
              } else {
                return errorMessageWithRefreshButton(
                  bloc,
                  "Some error occured.",
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Scaffold errorMessageWithRefreshButton(FoundTripsBloc bloc, String text) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                  onPressed: () async =>
                      bloc.add(InitFoundTrips(requestTripId)),
                  child: const Text(
                    'Refresh',
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _FoundTripsListItem extends StatelessWidget {
  final FoundTrip item;
  final String requestTripId;
  final DateFormat formatter = DateFormat("dd-MM-yyyy HH:mm:ss");

  _FoundTripsListItem(
      {Key? key, required this.item, required this.requestTripId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Available seats: ${item.remainingSeats}"),
              Text("Driver name: ${item.driverDisplayName}"),
              Text(
                  "Driver title: ${item.driverStatusCode} ${item.driverStatusLabel ?? ''}"),
              Text(
                  "Rating: ${item.driverRating}. Ratings: ${item.driverRatingsCount}"),
              Text(
                  "Departure time: ${formatter.format(DateTime.parse(item.fromCityDepartureTime).toLocal())}"),
              Text(
                  "Arrival time: ${formatter.format(DateTime.parse(item.toCityDepartureTime).toLocal())}"),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              final bloc = BlocProvider.of<FoundTripsBloc>(context);
              bloc.add(NotifyAgainEvent(item.id, requestTripId));
            },
            icon: const Icon(
              Icons.notification_important,
            ),
          ),
        ],
      ),
    );
  }
}
