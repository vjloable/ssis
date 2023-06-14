import 'package:flutter/cupertino.dart';
import 'package:ssis/misc/progressbar_states.dart';

class ProgressBarController extends ChangeNotifier {
  ProgressBarStates _states = ProgressBarStates.idle;

  void setState(ProgressBarStates value) {
    _states = value;
    notifyListeners();
  }

  ProgressBarStates getState() => _states;
}