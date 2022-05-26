import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/components/components_layaout.dart';
import 'package:todo_app/modules/done_tasks/done_tasks.dart';
import 'package:todo_app/modules/new_tasks/new_tasks.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../modules/archieved_tasks/archieved_tasks.dart';
import '../modules/components/constants.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDBState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: cubit.scaffoldKey,
            appBar: AppBar(
              title: Text('Todo App'),
            ),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) => cubit.screen[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.bottomSheet) {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit
                        .insertDataBase(
                            tiltle: cubit.controller.text,
                            date: cubit.datecontroller.text,
                            time: cubit.timecontroller.text)
                        .then((value) {});
                  }
                } else {
                  cubit.scaffoldKey.currentState
                      ?.showBottomSheet((context) => Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(20.0),
                            child: Form(
                              key: cubit.formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultFormField(
                                      controller: cubit.controller,
                                      type: TextInputType.text,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'title must not be empty';
                                        }
                                        return null;
                                      },
                                      label: 'Task Title',
                                      prefix: Icons.title,
                                      onTap: () {}),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultFormField(
                                      controller: cubit.timecontroller,
                                      type: TextInputType.datetime,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'time must not be empty';
                                        }
                                        return null;
                                      },
                                      label: 'Task Time',
                                      prefix: Icons.watch_later_outlined,
                                      onTap: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          cubit.timecontroller.text =
                                              value!.format(context).toString();
                                        });
                                      }),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultFormField(
                                      controller: cubit.datecontroller,
                                      type: TextInputType.datetime,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'date must not be empty';
                                        }
                                        return null;
                                      },
                                      label: 'Task Date',
                                      prefix: Icons.calendar_today,
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2023-12-01'))
                                            .then((value) {
                                          cubit.datecontroller.text =
                                              DateFormat.yMMMd().format(value!);
                                        });
                                      })
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.changeBottomSheet(isShow: false, icon: Icons.edit);
                  });

                  cubit.changeBottomSheet(isShow: true, icon: Icons.add);
                }

                cubit.controller.text = '';
                cubit.datecontroller.text = '';
                cubit.timecontroller.text = '';

              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                cubit.changeIndex(index);
                print(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
                BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archieved'),
              ],
            ),
          );
        },
      ),
    );
  }
}
