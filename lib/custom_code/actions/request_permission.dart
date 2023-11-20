// Automatic FlutterFlow imports

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

Future requestPermission() async {
  try{
  var types = [
    HealthDataType.STEPS,
    HealthDataType.HEART_RATE,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.SLEEP_SESSION
  ];
  HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

  var permissions = types.map((e) => HealthDataAccess.READ).toList();
  await Permission.activityRecognition.request();
  await Permission.location.request();
  var a;
  try {
    a = await health.requestAuthorization(types, permissions: permissions);
  } catch (error) {
    print("Exception in authorize: $error");
  }
  }catch(e){
    if (kDebugMode) {
      print('request permission failed $e');
    }
  }
}
