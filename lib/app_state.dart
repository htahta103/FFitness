import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _selectedGender = 'male';
  String get selectedGender => _selectedGender;
  set selectedGender(String _value) {
    _selectedGender = _value;
  }

  int _selectedHeight = 150;
  int get selectedHeight => _selectedHeight;
  set selectedHeight(int _value) {
    _selectedHeight = _value;
  }

  int _selectedWeight = 60;
  int get selectedWeight => _selectedWeight;
  set selectedWeight(int _value) {
    _selectedWeight = _value;
  }

  int _selectedAge = 25;
  int get selectedAge => _selectedAge;
  set selectedAge(int _value) {
    _selectedAge = _value;
  }

  String _goal = 'Get fitter';
  String get goal => _goal;
  set goal(String _value) {
    _goal = _value;
  }

  String _activityLevel = 'Intermediate';
  String get activityLevel => _activityLevel;
  set activityLevel(String _value) {
    _activityLevel = _value;
  }

  List<String> _goals = [
    'Gain weight',
    'Lose weight',
    'Get fitter',
    'Gain more flexible',
    'Learn the basic'
  ];
  List<String> get goals => _goals;
  set goals(List<String> _value) {
    _goals = _value;
  }

  void addToGoals(String _value) {
    _goals.add(_value);
  }

  void removeFromGoals(String _value) {
    _goals.remove(_value);
  }

  void removeAtIndexFromGoals(int _index) {
    _goals.removeAt(_index);
  }

  void updateGoalsAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _goals[_index] = updateFn(_goals[_index]);
  }

  void insertAtIndexInGoals(int _index, String _value) {
    _goals.insert(_index, _value);
  }

  List<String> _activities = [
    'Rookie',
    'Beginner',
    'Intermediate',
    'Advance',
    'True Beast'
  ];
  List<String> get activities => _activities;
  set activities(List<String> _value) {
    _activities = _value;
  }

  void addToActivities(String _value) {
    _activities.add(_value);
  }

  void removeFromActivities(String _value) {
    _activities.remove(_value);
  }

  void removeAtIndexFromActivities(int _index) {
    _activities.removeAt(_index);
  }

  void updateActivitiesAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _activities[_index] = updateFn(_activities[_index]);
  }

  void insertAtIndexInActivities(int _index, String _value) {
    _activities.insert(_index, _value);
  }

  int _heartRate = 0;
  int get heartRate => _heartRate;
  set heartRate(int _value) {
    _heartRate = _value;
  }

  int _sleep = 0;
  int get sleep => _sleep;
  set sleep(int _value) {
    _sleep = _value;
  }

  int _step = 0;
  int get step => _step;
  set step(int _value) {
    _step = _value;
  }

  int _calories = 0;
  int get calories => _calories;
  set calories(int _value) {
    _calories = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
