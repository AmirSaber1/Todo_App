import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator<String> validate,
  required String label,
  required IconData prefix,
  required GestureTapCallback onTap,
}) =>
    TextFormField(
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        labelText: label,
        border: OutlineInputBorder(),
      ),
      controller: controller,
      keyboardType: type,
      validator: validate,
    );

Widget buildTaskItem(Map model,context) => Dismissible(
  key: Key(model['id'].toString()),
   onDismissed: (direction){

    AppCubit.get(context).deleteDataBase(id: model['id']);
  },
  child:   Padding(

        padding: const EdgeInsets.all(20.0),

        child: Row(

          children: [

            CircleAvatar(

              backgroundColor: Colors.blue,

              radius: 34.0,

              child: Text(

                '${model['time']}',

                style: TextStyle(color: Colors.white),

              ),

            ),

            SizedBox(

              width: 15.0,

            ),

            Expanded(

              child: Column(

                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(

                    '${model['title']}',

                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),

                  ),

                  SizedBox(

                    height: 10.0,

                  ),

                  Text('${model['date']}'),

                ],

              ),

            ),

            SizedBox(

              width: 15.0,

            ),

            IconButton(

                onPressed: () {



                  AppCubit.get(context).updateDataBase(status: 'done', id: model['id']);

                },

                icon: Icon(

                  Icons.check_circle_rounded,

                  color: Colors.green,

                )),

            IconButton(

                onPressed: () {

                  AppCubit.get(context).updateDataBase(status: 'archive', id: model['id']);



                },

                icon: Icon(

                  Icons.archive,

                  color: Colors.black38,

                )),

          ],

        ),

      ),
);
