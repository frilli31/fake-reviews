import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'package:http/http.dart' as http;


final uuid = Uuid();

class LogRecipient {
  String serverAddress = 'https://fake-reviews-10f57.firebaseio.com';


  final List<TouchEvent> _pointerEvents = [];
  final List<ViewRenderedEvent> _renderedEvent = [];

  final _uuid = uuid.v4(options: {'rng': UuidUtil.cryptoRNG});


  void addPointerEvent(PointerEvent item) {
    _pointerEvents.add(
      TouchEvent(
        pressure: item.pressure,
        area: item.size,
        x: item.position.dx,
        y: item.position.dy,
        description: item.toStringFull(),
      )
    );
  }

  void addRenderedEvent(ViewRenderedEvent event) {
    _renderedEvent.add(event);

    final responseRendered = http.put(
      '$serverAddress/rendering/$_uuid.json',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(_renderedEvent),
    );
  }

  Future<void> addReview(ReviewEvent event) async {

    final responsePath = http.put(
      '$serverAddress/path/${event.item}/$_uuid.json',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(_pointerEvents),
    );

    final responseRating = http.put(
      '$serverAddress/ratings/${event.item}/$_uuid.json',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(event.stars),
    );

    await responsePath;

    _pointerEvents.clear();
  }

  void sendScreenDetails(ScreenDetails details) {
    final responseRating = http.put(
      '$serverAddress/screenDetails/$_uuid.json',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(details),
    );
  }
}

class ReviewEvent {
  ReviewEvent({
    @required this.stars,
    @required this.item,
  });

  int stars;
  String item;

  Map<String, dynamic> toJson() => {
        'stars': stars,
      };
}

class TouchEvent {
  double pressure;
  double area;
  double x;
  double y;
  String description;

  TouchEvent({
    this.pressure,
    this.area,
    this.x,
    this.y,
    this.description,
  });

  int timestamp = DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() => {
    'pressure': pressure,
    'area': area,
    'position': {
      'x': x,
      'y': y,
    },
    'description': description,
    'timestamp': timestamp,
  };
}

class ViewRenderedEvent {
  String item;
  String view;

  ViewRenderedEvent({
    @required this.item,
    @required this.view,
  });

  int timestamp = DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() => {
    'item': item,
    'timestamp': timestamp,
    'view': view,
  };
}

class ScreenDetails {
  double width;
  double height;
  String details;

  ScreenDetails({
    @required this.width,
    @required this.height,
    @required this.details,
  });

  int timestamp = DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() => {
    'width': width,
    'height': height,
    'details': details,
  };
}