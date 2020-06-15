import 'dart:async';

import 'package:registration/bloc/stateChangeBloc_Event.dart';

class StateChangerBloc {
  int _blocFormIndex = 1;

  final _blocStreamController = StreamController<int>();

  StreamSink<int> get _inBlocFormIndex => _blocStreamController.sink;

  Stream<int> get formValue => _blocStreamController.stream;

  final _blocFormEventController = StreamController<StateChangeEvent>();

  Sink<StateChangeEvent> get blocFormIndexSink => _blocFormEventController.sink;

  StateChangerBloc() {
    _blocFormEventController.stream.listen(_mapFormToState);
  }

  void _mapFormToState(StateChangeEvent event) {
    if (_blocFormIndex == 1) {
      _blocFormIndex = 2;
    } else if (_blocFormIndex == 2) {
      _blocFormIndex = 1;
    }

    _inBlocFormIndex.add(_blocFormIndex);
  }

  void dispose() {
    _blocStreamController.close();
    _blocFormEventController.close();
  }
}
