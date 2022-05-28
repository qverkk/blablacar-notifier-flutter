import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/auth/bloc/auth_bloc.dart';
import 'package:myapp/core/found-trips/bloc/found_trips_bloc.dart';
import 'package:myapp/core/found-trips/models/found_trips.dart';
import 'package:myapp/core/found-trips/repository/found_trips_repository.dart';
import 'package:myapp/core/found-trips/service/found_trips_service.dart';

class FoundTripsScreen extends StatelessWidget {
  const FoundTripsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = FoundTripsService();
    final repository = FoundTripsRepository(service: service);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final bloc = FoundTripsBloc(
      repository: repository,
      authBloc: authBloc,
    )..add(InitFoundTrips());

    return RepositoryProvider(
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
                  body: ListView.separated(
                    itemBuilder: (context, index) =>
                        _FoundTripsListItem(item: state.data[index]),
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                    ),
                    itemCount: state.data.length,
                  ),
                ),
                onRefresh: () =>
                    Future.microtask(() => bloc.add(InitFoundTrips())),
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
                  onPressed: () async => bloc.add(InitFoundTrips()),
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

  const _FoundTripsListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text("${item.id} : ${item.remainingSeats}"),
          const Spacer(),
          IconButton(
            onPressed: () {
              final bloc = BlocProvider.of<FoundTripsBloc>(context);
              bloc.add(NotifyAgainEvent(item.id));
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
