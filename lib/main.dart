import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/counter/BloC/cubit.dart';
import 'package:todo_app/modules/counter/counter.dart';
import 'package:todo_app/shared/bloc_observer.dart';
import 'layout/home_layout.dart';

void main() {
  BlocOverrides.runZoned(
        () {

    },
    blocObserver: MyBlocObserver(),
  );

  runApp(MaterialApp(

    home: HomeLayout(),

  ));
}
