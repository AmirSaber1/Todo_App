import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/components/constants.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../components/components_layaout.dart';

class ArchievedTasks extends StatelessWidget {
  const ArchievedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).archivedTasks;

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
    );
  }
}
