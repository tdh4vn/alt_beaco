library altbeacon;

import 'dart:async';

import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part 'beacon/beacon.dart';
part 'beacon/bluetooth_state.dart';
part 'beacon/authorization_status.dart';
part 'beacon/monitoring_result.dart';
part 'beacon/ranging_result.dart';
part 'beacon/region.dart';

final Altbeacon altBeacon = new Altbeacon._internal();

class Altbeacon {

  Altbeacon._internal();

  static const MethodChannel _methodChannel =
    const MethodChannel('altbeacon');

  static const EventChannel _rangingChannel =
    EventChannel('flutter_beacon_event');

  static const EventChannel _monitoringChannel =
    EventChannel('flutter_beacon_event_monitoring');

  static const EventChannel _bluetoothStateChangedChannel =
    EventChannel('flutter_bluetooth_state_changed');

  static const EventChannel _authorizationStatusChangedChannel =
    EventChannel('flutter_authorization_status_changed');

  Stream<RangingResult> _onRanging;

  Stream<MonitoringResult> _onMonitoring;

  Stream<BluetoothState> _onBluetoothState;

  Stream<AuthorizationStatus> _onAuthorizationStatus;

  Future<bool> get initializeScanning async {
    final result = await _methodChannel.invokeMethod('initialize');
    print("flutter initialize done");


    _rangingChannel
        .receiveBroadcastStream()
        .map((dynamic event) => event).listen((event) {
          print("event");
          print(event);

    });


    if (result is bool) {

      return result;
    } else if (result is int) {
      return result == 1;
    }

    return result;
  }
}
