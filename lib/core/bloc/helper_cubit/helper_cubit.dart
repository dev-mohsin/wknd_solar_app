import 'package:bloc/bloc.dart';

class HelperCubit<T> extends Cubit<T> {
  HelperCubit(T initialState) : super(initialState);

  void init() {
    emit(state);
  }

  void update(T newState) {
    emit(newState);
  }

  void onChanged(T newState) {
    emit(newState);
  }
}
