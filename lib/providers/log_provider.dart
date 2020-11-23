import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'package:http/http.dart' as http;

final bool DEBUG = false;

final uuid = Uuid();

class LogProvider {

  String serverAddress = DEBUG
    ? 'http://10.0.2.2:9000/'
    : 'https://fake-reviews-10f57.firebaseio.com';



  final List<List<TouchEvent>> _pointerEvents = [];
  final List<ViewRenderedEvent> _renderedEvent = [];

  final _uuid = uuid.v4(options: {'rng': UuidUtil.cryptoRNG});



  Future<void> sendDeviceInfo() async {
    Map<String, dynamic> deviceData = {};
    try {
      deviceData.addAll({
        'os': Platform.operatingSystem,
        'osVersion': Platform.operatingSystemVersion,
        'numberOfProcessors': Platform.numberOfProcessors,
      });

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if(Platform.isAndroid) {
        AndroidDeviceInfo data = await deviceInfo.androidInfo;
        deviceData.addAll({
          'board': data.board,
          'brand': data.brand,
          'device': data.device,
          'display': data.display,
          'fingerprint': data.fingerprint,
          'hardware': data.hardware,
          'host': data.host,
          'id': data.id,
          'manufacturer': data.manufacturer,
          'model': data.model,
          'product': data.product,
          'tags': data.tags,
          'type': data.type,
          'isPhysicalDevice': data.isPhysicalDevice,
        });
      }
      if(Platform.isIOS) {
        IosDeviceInfo data = await deviceInfo.iosInfo;
        deviceData.addAll({
          'name': data.name,
          'systemName': data.systemName,
          'systemVersion': data.systemVersion,
          'model': data.model,
          'localizedModel': data.localizedModel,
          'id': data.identifierForVendor,
          'isPhysicalDevice': data.isPhysicalDevice,
        });
      }

    } on PlatformException {
      deviceData.putIfAbsent('error', () => 'An error happened collecting device info');
    }

    http.put(
      '$serverAddress/deviceInfo/$_uuid.json',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(deviceData),
    );
  }


  void addStartTraceEvent(PointerDownEvent item) {
    _pointerEvents.add([
    TouchEvent(
      pressure: item.pressure / (item.pressureMax - item.pressureMin),
      area: item.size,
      x: item.localPosition.dx,
      y: item.localPosition.dy,
      timestamp: item.timeStamp.inMilliseconds,
    )
    ]);
  }

  void addPointerEvent(PointerEvent item) {
    _pointerEvents.last.add(
        TouchEvent(
          pressure: item.pressure / (item.pressureMax - item.pressureMin),
          area: item.size,
          x: item.localPosition.dx,
          y: item.localPosition.dy,
          timestamp: item.timeStamp.inMilliseconds,
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

  void sendSurveyAnswers(List<List<String>> answers) {
    final responseSurvey = http.put(
      '$serverAddress/survey/$_uuid.json',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(answers),
    );
  }

  Future<void> addReview(ReviewEvent event) async {

    final responsePath = http.put(
      '$serverAddress/path-star/${event.item.split('.').first}/$_uuid.json',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(_pointerEvents),
    );

    final responseRating = http.put(
      '$serverAddress/ratings/${event.item.split('.').first}/$_uuid.json',
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
  int timestamp;

  TouchEvent({
    this.pressure,
    this.area,
    this.x,
    this.y,
    this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'pressure': pressure,
    'area': area,
    'position': {
      'x': x,
      'y': y,
    },
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