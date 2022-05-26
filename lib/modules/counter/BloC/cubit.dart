import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/counter/BloC/states.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterIntialState());

  static CounterCubit get(context) => BlocProvider.of(context);

  late int counter=0;

  void minus() {
    counter--;
    emit(CounterMinusState());
  }

  void plus() {
    counter++;
    emit(CounterPlusState());
  }
}
