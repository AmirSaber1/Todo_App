import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../../modules/archieved_tasks/archieved_tasks.dart';
import '../../modules/components/constants.dart';
import '../../modules/done_tasks/done_tasks.dart';
import '../../modules/new_tasks/new_tasks.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());

  static AppCubit get(context) => BlocProvider.of(context);
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  List<Widget> screen = [NewTasks(), DoneTasks(), ArchievedTasks()];
  int currentIndex = 0;
  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool bottomSheet = false;
  IconData fabIcon = Icons.edit;
  var controller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppBottomNavBarState());
  }

  void createDataBase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
          .then((value) {
        print('Table Created');
      }).catchError((error) {
        print('Error ${error.toString()}');
      });
      print('Database Created');
    }, onOpen: (database) {
      getDataFromDB(database);
      print('Database Opened');
    }).then((value) {
      database = value;

      emit(AppCreateDBState());
    });
  }

  Future insertDataBase({required tiltle, required date, required time}) async {
    return await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks (title, date, time, status) VALUES ("$tiltle","$date","$time","new")')
          .then((value) {
        print('$value Inserted Successfully');

        emit(AppInsertDBState());

        getDataFromDB(database);
      }).catchError((error) {
        print('insertion Error ${error.toString()}');
      });
    });
  }

  void getDataFromDB(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }

        print(element['status']);
      });
      emit(AppGetDBState());
    });
  }

  void updateDataBase({required String status, required int id}) async {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', '$id']).then((value) {
      getDataFromDB(database);
      emit(AppGUpdateDBState());
    });
  }

  void deleteDataBase({required int id}) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDB(database);
      emit(AppGDeleteDBState());
    });
  }

  changeBottomSheet({required bool isShow, required IconData icon}) {
    bottomSheet = isShow;
    fabIcon = icon;

    emit(AppBottomSheetState());
  }
}
