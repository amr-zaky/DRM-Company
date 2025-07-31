import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bottom_nav_cubit_state.dart';

class BottomNavCubit extends Cubit<BottomNavCubitState> {
  BottomNavCubit() : super(BottomNavInitialState());

  static BottomNavCubit get(BuildContext context) => BlocProvider.of(context);
  int selectedIndex = 0;

  void selectItem(int index) {
    selectedIndex = index;

    emit(BottomNavChangeState());
  }

  bool isItemSelected(int index) {
    return selectedIndex == index;
  }
}
