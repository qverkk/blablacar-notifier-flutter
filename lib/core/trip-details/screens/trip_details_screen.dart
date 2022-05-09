import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/auth/bloc/auth_bloc.dart';
import 'package:myapp/core/trip-details/bloc/trip_details_bloc.dart';
import 'package:myapp/core/trip-details/models/trip_details.dart';
import 'package:myapp/core/trip-details/repository/trip_details_repository.dart';
import 'package:myapp/core/trip-details/service/trip_details_service.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = TripDetailsService();
    final repository = TripDetailsRepository(service: service);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final bloc = TripDetailsBloc(
      repository: repository,
      authBloc: authBloc,
    )..add(InitTripDetails());

    return RepositoryProvider(
      create: ((context) => repository),
      child: BlocProvider(
        create: ((context) => bloc),
        child: BlocConsumer<TripDetailsBloc, TripDetailsState>(
          listener: (context, state) => {},
          builder: (context, state) {
            if (state is Loading) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state is TripDetailsLoaded) {
              return RefreshIndicator(
                child: Scaffold(
                  body: ListView.separated(
                    itemBuilder: (context, index) =>
                        _TripDetailsListItem(item: state.data[index]),
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                    ),
                    itemCount: state.data.length,
                  ),
                ),
                onRefresh: () =>
                    Future.microtask(() => bloc.add(InitTripDetails())),
              );
            } else if (state is TripDetailsError) {
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

  Scaffold errorMessageWithRefreshButton(TripDetailsBloc bloc, String text) {
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
                  onPressed: () async => bloc.add(InitTripDetails()),
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

class _TripDetailsListItem extends StatelessWidget {
  final TripDetails item;

  const _TripDetailsListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("${item.fromCity} -> ${item.toCity}");
  }
}
