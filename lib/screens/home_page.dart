import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myapp/routes/app_router.gr.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      backgroundColor: Colors.indigo,
      routes: const [
        HomeScreenRouter(),
        TripDetailsRouter(),
        FoundTripsRouter(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return SalomonBottomBar(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            SalomonBottomBarItem(
              selectedColor: Colors.blue[200],
              icon: const Icon(
                Icons.person,
                size: 30,
              ),
              title: const Text('Session'),
            ),
            SalomonBottomBarItem(
              selectedColor: Colors.pinkAccent[100],
              icon: const Icon(
                Icons.map,
                size: 30,
              ),
              title: const Text('Trip details'),
            ),
            SalomonBottomBarItem(
              selectedColor: Colors.pinkAccent[100],
              icon: const Icon(
                Icons.notifications,
                size: 30,
              ),
              title: const Text('Found trips'),
            )
          ],
        );
      },
    );
  }
}
