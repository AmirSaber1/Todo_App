import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/components/constants.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../components/components_layaout.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;

        return ConditionalBuilder(
          condition: tasks.length > 0,
          builder: (context) {
            return ListView.separated(
                itemBuilder: (context, index) =>
                    buildTaskItem(tasks[index], context),
                separatorBuilder: (context, index) => Container(
                      color: Colors.grey[300],
                      height: 1.0,
                      width: double.infinity,
                    ),
                itemCount: tasks.length);
          },
          fallback: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.task),
                SizedBox(height: 10.0,),
                Text("Not tasks yet, Let's do some tasks"),
              ],
            ),
          ),
        );
      },
    );
  }
}
