import 'package:flutter/material.dart';
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
  set selectedGender(String value) {
    _selectedGender = value;
  }

  int _selectedHeight = 150;
  int get selectedHeight => _selectedHeight;
  set selectedHeight(int value) {
    _selectedHeight = value;
  }

  int _selectedWeight = 60;
  int get selectedWeight => _selectedWeight;
  set selectedWeight(int value) {
    _selectedWeight = value;
  }

  int _selectedAge = 25;
  int get selectedAge => _selectedAge;
  set selectedAge(int value) {
    _selectedAge = value;
  }

  String _goal = 'Get fitter';
  String get goal => _goal;
  set goal(String value) {
    _goal = value;
  }

  String _activityLevel = 'Intermediate';
  String get activityLevel => _activityLevel;
  set activityLevel(String value) {
    _activityLevel = value;
  }

  List<String> _goals = [
    'Gain weight',
    'Lose weight',
    'Get fitter',
    'Gain more flexible',
    'Learn the basic'
  ];
  List<String> get goals => _goals;
  set goals(List<String> value) {
    _goals = value;
  }

  void addToGoals(String value) {
    _goals.add(value);
  }

  void removeFromGoals(String value) {
    _goals.remove(value);
  }

  void removeAtIndexFromGoals(int index) {
    _goals.removeAt(index);
  }

  void updateGoalsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    _goals[index] = updateFn(_goals[index]);
  }

  void insertAtIndexInGoals(int index, String value) {
    _goals.insert(index, value);
  }

  List<String> _activities = [
    'Rookie',
    'Beginner',
    'Intermediate',
    'Advance',
    'True Beast'
  ];
  List<String> get activities => _activities;
  set activities(List<String> value) {
    _activities = value;
  }

  void addToActivities(String value) {
    _activities.add(value);
  }

  void removeFromActivities(String value) {
    _activities.remove(value);
  }

  void removeAtIndexFromActivities(int index) {
    _activities.removeAt(index);
  }

  void updateActivitiesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    _activities[index] = updateFn(_activities[index]);
  }

  void insertAtIndexInActivities(int index, String value) {
    _activities.insert(index, value);
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
