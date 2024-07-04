import 'package:bloc/bloc.dart';

class CheckBoxCubit extends Cubit<List<bool>> {
  CheckBoxCubit() : super([false, false, false]);

  void onChanged(bool value, int index) {
    state[index] = value;
    emit(List.from(state));
  }
}
