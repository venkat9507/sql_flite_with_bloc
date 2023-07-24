
// This function will be triggered when the floating button is pressed
// It will also be triggered when you want to update an item
import 'package:flutter/material.dart';
import 'package:sqflite_test/features/dashboard_screen/bloc/dashboard_bloc.dart';

import '../../database/local_database.dart';
import '../data/user_data.dart';

void showForm({int? id,BuildContext? context,DashboardBloc? dashboardBloc}) async {
   TextEditingController userNameController = TextEditingController();
   TextEditingController userDescriptionController = TextEditingController();
  if (id != null) {
    // id == null -> create new item
    // id != null -> update an existing item
    final existingJournal =
    userList.firstWhere((element) => element['id'] == id);
    userNameController.text = existingJournal['userName'];
    userDescriptionController.text = existingJournal['userDescription'];
  }

  showModalBottomSheet(
      context: context!,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          // this will prevent the soft keyboard from covering the text fields
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: userNameController,
              decoration: const InputDecoration(hintText: 'User Name'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: userDescriptionController,
              decoration: const InputDecoration(hintText: 'User Description'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                // Save new journal
                if (id == null) {
                  dashboardBloc?.add(DashboardUpdateOGButtonEvent(id:null,userName: userNameController.text,userDescription: userDescriptionController.text ));
                }

                if (id != null) {
                   dashboardBloc?.add(DashboardUpdateOGButtonEvent(id:id,userName: userNameController.text,userDescription: userDescriptionController.text ));

                }

                // Clear the text fields
                userNameController.text = '';
                userDescriptionController.text = '';

                // Close the bottom sheet
                Navigator.of(context).pop();
              },
              child: Text(id == null ? 'Create New' : 'Update'),
            )
          ],
        ),
      ));
}

// Insert a new journal to the database
Future<void> addItem(String userName,String userDescription) async {
  await LocalDataBase.createUser(
      userName, userDescription);
  refreshJournals();
}

// Update an existing journal
Future<void> updateItem(int id,String userName,String userDescription) async {
  await LocalDataBase.updateUser(
      id, userName, userDescription);
  refreshJournals();
}

// Delete an item
void deleteItem(int id) async {
  await LocalDataBase.deleteUser(id);

  refreshJournals();
}

// This function is used to fetch all data from the database
 refreshJournals() async {
  final data = await LocalDataBase.getUsers();
  userList = data;

}