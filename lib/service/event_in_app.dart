import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants.dart';
import '../enums.dart';

class EventModel {
  final EventType eventType;
  final Map<String, dynamic> payload;

  EventModel(this.eventType, this.payload);
}

class EventInApp {
  // create singleton
  static final EventInApp _singleton = EventInApp._internal();

  factory EventInApp() {
    return _singleton;
  }

  EventInApp._internal() {
    if (!isWebMobile) _watch();
  }

  // create stream
  final controller = StreamController<EventModel>.broadcast();

  // Supabase Realtime Channel
  final gameChannel =
      supabase.channel('game', opts: const RealtimeChannelConfig());

  // Supabase Realtime Subscription
  _watch() {
    gameChannel.on(
        RealtimeListenTypes.broadcast,
        ChannelFilter(
          event: EventType.startTap.name,
        ), (payload, [ref]) {
      print('start tap');
      controller.add(EventModel(EventType.startTap, payload));
    });

    gameChannel.on(
        RealtimeListenTypes.broadcast,
        ChannelFilter(
          event: EventType.stopTap.name,
        ), (payload, [ref]) {
      print('stop tap');
      controller.add(EventModel(EventType.stopTap, payload));
    });

    gameChannel.on(
        RealtimeListenTypes.broadcast,
        ChannelFilter(
          event: EventType.getGift.name,
        ), (payload, [ref]) {
      print('payload: $payload');
      controller.add(EventModel(EventType.getGift, payload));
    });

    gameChannel.on(
        RealtimeListenTypes.broadcast,
        ChannelFilter(
          event: EventType.restartGame.name,
        ), (payload, [ref]) {
      print('restart game');
      controller.add(EventModel(EventType.restartGame, payload));
    });

    gameChannel.on(
        RealtimeListenTypes.broadcast,
        ChannelFilter(
          event: EventType.start.name,
        ), (payload, [ref]) {
      print('start game');
      controller.add(EventModel(EventType.start, payload));
    });
  }
}
