import 'package:flutter/cupertino.dart';
// import 'package:ssis/models/course_model.dart';

class CardCheckController extends ChangeNotifier {
  final Map<int, bool> _mapCardCheckSubHeads = {};
  final Map<int, bool> _mapCardCheckHead = {};
  final Map<int, dynamic> _submissionData = {};
  final Map<int, dynamic> _completeData = {};

  /// Private condition validation method
  /// to check if [index] is the head
  /// returns true if it is a head
  /// and false if otherwise
  bool _isHead(int index) => index == 0;

  /// Private condition validation method
  /// to check if all sub head checkboxes are checked
  bool _areSubHeadsChecked() {
    return _mapCardCheckSubHeads.values.every((element) => element == true);
  }

  /// Private condition validation method
  /// to check if head checkbox is checked
  bool _isHeadChecked() {
    return _mapCardCheckHead.values.first == true;
  }

  dynamic getSubmissionData() {
    print(_submissionData.values.first);
    return _submissionData.values.first;
  }

  List<dynamic> getSubmissionListData() {
    return _submissionData.values.toList();
  }

  void uncheckAll () {
    _mapCardCheckSubHeads.forEach((key, value) {
      _mapCardCheckSubHeads[key] = false;
    });
    _mapCardCheckHead.forEach((key, value) {
      _mapCardCheckHead[key] = false;
    });
    notifyListeners();
  }

  /// Method that counts all checked sub head checkboxes
  int countChecks() {
    int counter = 0;
    for (var element in _mapCardCheckSubHeads.values) {
      if (element) {
        counter++;
      }
    }
    return counter;
  }

  /// Method that return the total number of sub head checkboxes
  int maxCheck() {
    return _mapCardCheckSubHeads.values.length;
  }

  /// Instance initializer method
  void initInstance(int index, dynamic item) {
    if (_isHead(index)) {
      _mapCardCheckHead[index] = false;
    } else {
      _mapCardCheckSubHeads[index] = false;
      _completeData[index] = item;
    }
  }

  void resetSubmission() {
    _submissionData.clear();
    _mapCardCheckSubHeads.clear();
  }

  /// Instance disposer method
  void disposeInstance(int index) {
    if (_isHead(index)) {
      _mapCardCheckHead.remove(index);
    } else {
      _mapCardCheckSubHeads.remove(index);
    }
    _submissionData.remove(index);
    _completeData.remove(index);
  }

  /// Getter method
  bool get(int index) {
    bool value = false;
    if (_isHead(index)) {
      if (_mapCardCheckHead[index] != null) {
        value = _mapCardCheckHead[index]!;
      }
    } else {
      if (_mapCardCheckSubHeads[index] != null) {
        value = _mapCardCheckSubHeads[index]!;
      }
    }
    return value;
  }

  /// Setter method
  void set(int index, bool value, dynamic item) {
    if (_isHead(index)) {
      _mapCardCheckHead[index] = value;
      if (_isHeadChecked()) {
        _mapCardCheckSubHeads.forEach((key, value) {
          _mapCardCheckSubHeads[key] = true;
        });
        _submissionData.clear();
        _completeData.forEach((key, value) {
          _submissionData[key] = value;
        });
      } else {
        _mapCardCheckSubHeads.forEach((key, value) {
          _mapCardCheckSubHeads[key] = false;
        });
        _submissionData.clear();
      }
    } else {
      _mapCardCheckSubHeads[index] = value;
      value ? _submissionData[index] = item : _submissionData.remove(index);
      if (_areSubHeadsChecked()) {
        _mapCardCheckHead.forEach((key, value) {
          _mapCardCheckHead[key] = true;
        });
      } else {
        _mapCardCheckHead.forEach((key, value) {
          _mapCardCheckHead[key] = false;
        });
      }
    }
    notifyListeners();
  }

}
