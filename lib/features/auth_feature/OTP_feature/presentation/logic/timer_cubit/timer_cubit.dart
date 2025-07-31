import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'timer_states.dart';

class TimerCubit extends Cubit<TimerStates> {
  TimerCubit() : super(TimerStatesInit());

  static TimerCubit get(BuildContext context) => BlocProvider.of(context);

  late Timer _timer;
  int time = 60;

  void startTimer({int timerSeconds = 60}) {
    time = timerSeconds;
    const Duration oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (time == 0) {
          timer.cancel();
          stopTimer();
        } else {
          time--;
          emit(TimerClickState());
        }
      },
    );
    emit(TimerStartState());
  }

  void stopTimer() {
    _timer.cancel();
    emit(TimerEndState());
  }
}
