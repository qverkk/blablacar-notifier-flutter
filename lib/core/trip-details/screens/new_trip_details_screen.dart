import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/trip-details/bloc/trip_details_bloc.dart';
import 'package:myapp/core/trip-details/models/trip_details.dart';

class NewTripDetailsScreen extends StatefulWidget {
  const NewTripDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewTripDetailsScreenState();
}

class _NewTripDetailsScreenState extends State<NewTripDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fromCityTextController = TextEditingController();
  final _toCityTextController = TextEditingController();
  String _selectedDate = "Tap to select a date";

  void _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
        context: context,
        initialDate: _selectedDate.startsWith('Tap')
            ? DateTime.now()
            : DateTime.parse(_selectedDate),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));

    if (d != null) {
      setState(() {
        _selectedDate = d.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new trip detail'),
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
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
                controller: _fromCityTextController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'From city',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
                controller: _toCityTextController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'To city',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: OutlinedButton(
                onPressed: () {
                  _selectDate(context);
                },
                style: OutlinedButton.styleFrom(
                  primary: Colors.teal,
                  minimumSize: const Size.fromHeight(40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedDate),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var bloc = BlocProvider.of<TripDetailsBloc>(context);
                    var userRegistrationToken =
                        await FirebaseMessaging.instance.getToken() as String;
                    bloc.add(AddNewTripDetails(TripDetails(
                      endDate: DateTime.parse(_selectedDate),
                      fromCity: _fromCityTextController.text,
                      toCity: _toCityTextController.text,
                      startDate: DateTime.parse(_selectedDate),
                      userRegistrationToken: userRegistrationToken,
                      foundTrips: 0,
                    )));
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  minimumSize: const Size.fromHeight(40),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
