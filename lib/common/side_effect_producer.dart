import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";

mixin SideEffectProducer<T, S> on BlocBase<S> {
  final _controller = StreamController<T>.broadcast();

  Stream<T> get sideEffects => _controller.stream;

  Function(T) get produceEffect => _controller.sink.add;

  @override
  Future<void> close() {
    _controller.close();
    return super.close();
  }
}
