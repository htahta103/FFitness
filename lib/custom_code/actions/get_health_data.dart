// Automatic FlutterFlow imports
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future getHealthData(DateTime date) async {
  try {
    var types = [
      HealthDataType.STEPS,
      HealthDataType.HEART_RATE,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.SLEEP_SESSION
    ];
    HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

    var midnight = DateTime(date.year, date.month, date.day);
    var endDate = DateTime(date.year, date.month, date.day, 23, 59, 59);
    int? steps = await health.getTotalStepsInInterval(midnight, endDate);
    var heartRate = await health
        .getHealthDataFromTypes(midnight, endDate, [HealthDataType.HEART_RATE]);
    var sleep = await health.getHealthDataFromTypes(
        midnight, endDate, [HealthDataType.SLEEP_SESSION]);
    var active_calor = await health.getHealthDataFromTypes(midnight, endDate,
        [HealthDataType.ACTIVE_ENERGY_BURNED, HealthDataType.STEPS]);
    var zz = heartRate.isNotEmpty
        ? int.tryParse((heartRate[0]).toJson()['value']['numericValue'] ?? 0) ??
            0
        : 0;
    FFAppState().heartRate = heartRate.isNotEmpty
        ? int.tryParse((heartRate[0]).toJson()['value']['numericValue'] ?? 0) ??
            0
        : 0;
    FFAppState().sleep = sleep.isNotEmpty
        ? getSumData(sleep)
        : 0;
    FFAppState().step = steps ?? 0;
    FFAppState().calories = active_calor.isNotEmpty
        ? getSumData(active_calor)
        : 0;
    FFAppState().update(() {});
    // print('heart rate nè: => ' + heartRate[0].value.toString());
    // var ss = sleep[0].toJson()['value']['numericValue'];
    // print('Sleep nè: => ' + ss);
    // print('heart rate nè: => ' + steps.toString());
    var d = 1;
  } catch (e) {
    print('get health data check ' + e.toString());
  }
}

int getSumData(active_calors) {
  var res = 0;
  for (int i = 0; i < active_calors.length; i++) {
    res += int.tryParse(
            (active_calors[i]).toJson()['value']['numericValue'] ?? 0) ??
        0;
  }
  return res;
}
