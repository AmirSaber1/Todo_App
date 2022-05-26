import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/counter/BloC/cubit.dart';
import 'package:todo_app/modules/counter/BloC/states.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(
        builder: (context,state) {

          return Scaffold(
            appBar: AppBar(
              title: Text("Counter"),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {
                    CounterCubit.get(context).minus();
                  }, child: Text('Minus')),
                  Text('${CounterCubit.get(context).counter}'),
                  TextButton(onPressed: () {
                    CounterCubit.get(context).plus();
                  }, child: Text('Plus'))
                ],
              ),
            ),
          );
        } ,
        listener: (context, state){},

      ),
    );
  }
}
