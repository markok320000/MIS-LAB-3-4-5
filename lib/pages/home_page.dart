import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:event_scheduler_project/api/notification_api.dart';
import 'package:event_scheduler_project/components/event_card.dart';
import 'package:event_scheduler_project/models/eventMode.dart';
import 'package:event_scheduler_project/models/user.dart';
import 'package:event_scheduler_project/pages/my_events_page.dart';
import 'package:event_scheduler_project/resources/auth_methods.dart';
import 'package:event_scheduler_project/resources/firestore_methods.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int eventsToday = 0;
  List<Event> events = [];

  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationApi.onActionRecievedMethod,
      onDismissActionReceivedMethod:
          NotificationApi.onDismissActionReceivedMethod,
      onNotificationCreatedMethod: NotificationApi.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationApi.onNotificationDisplayedMethod,
    );
    super.initState();

    getEvents();
  }

  int countEventsStartingToday(List<Map<String, dynamic>> events) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return events.where((event) {
      final eventDate = event['eventDate'];
      final eventDay = DateTime(eventDate.year, eventDate.month, eventDate.day);
      return eventDay == today;
    }).length;
  }

  Future<void> getEvents() async {
    List<Event> fetchedEvents = await FireStoreMethods().getEvents();
    List<String> favouriteEventsIds = await getFavouriteEventsIds();

    // List<Event> fliteredEvents =
    //     filterEventsByFavorite(fetchedEvents, favouriteEventsIds);

    setState(() {
      print("stigaa");
      this.events = filterEventsByFavorite(fetchedEvents, favouriteEventsIds);
    });
  }

  List<Event> filterEventsByFavorite(
      List<Event> events, List<String> favoriteEventIds) {
    return events
        .where((event) => !favoriteEventIds.contains(event.eventId))
        .toList();
  }

  Future<List<String>> getFavouriteEventsIds() async {
    User user = await AuthMethods().getUserDetails();

    return user.myEvents.map((e) => e.toString()).toList();
  }

  void addToFavourites(String eventId, String userId, context) async {
    String res = await FireStoreMethods().addToFavourites(eventId, userId);
    setState(() {
      events.removeWhere((element) => element.eventId == eventId);
    });

    if (res == "success") {
      showSnackBar(context, "Added To Favourites");
    }
  }

  Future<void> scheduleNewNotification() async {
    printScheduledNotifications();
  }

  Future<void> printScheduledNotifications() async {
    List<NotificationModel> scheduledNotifications =
        await AwesomeNotifications().listScheduledNotifications();

    for (var notification in scheduledNotifications) {
      print(notification.content);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Events')),
      body: Container(
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  ...events.map((event) {
                    return EventCard(
                      event: event,
                      addToFavourites: addToFavourites,
                    );
                  }).toList(),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
