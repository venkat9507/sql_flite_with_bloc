
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_test/features/const/circular_progress.dart';
import 'package:sqflite_test/features/dashboard_screen/data/user_data.dart';

import '../../database/local_database.dart';
import '../bloc/dashboard_bloc.dart';
import 'bottom_sheet.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

   DashboardBloc? dashboardBloc;

  List<Map<String, dynamic>> _userList = [];



  @override
  void initState() {
    super.initState();
    dashboardBloc= context.read <DashboardBloc>();
    dashboardBloc!.add(DashboardInitialEvent());
  }







  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      bloc: dashboardBloc,
      listenWhen: (previous, current) => current is DashboardActionState,
      buildWhen: (previous, current) => current is! DashboardActionState,
  listener: (context, state) {
    if (state is DashboardFloatingActionButtonLoadingState) {

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(' Add User  Loading ... '),duration: Duration(milliseconds: 300),));
    }else if  (state is DashboardFloatingActionButtonErrorState) {

      ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(' Add button error ${state.error}')));
    }else if  (state is DashboardFloatingActionButtonLoadedSuccessState) {

      showForm(id: null,context: context,dashboardBloc: dashboardBloc);
    } else   if (state is DashboardDeleteButtonLoadingState) {

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(' Delete User  Loading ... '),duration: Duration(milliseconds: 300),));
    }else if  (state is DashboardDeleteButtonErrorState) {

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(' delete error ${state.error}')));
    }else if  (state is DashboardDeleteButtonLoadedSuccessState) {

      deleteItem(state.id!);
    }else   if (state is DashboardUpdateButtonLoadingState) {

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(' Update User  Loading ... '),duration: Duration(milliseconds: 300),));
    }else if  (state is DashboardUpdateButtonErrorState) {

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(' update error ${state.error}')));
    }else if  (state is DashboardUpdateButtonLoadedSuccessState) {

      showForm(id: state.id,context: context,dashboardBloc: dashboardBloc);
    }
    else   if (state is DashboardUpdateOGButtonLoadingState) {

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(' Update User  Loading ... '),duration: Duration(milliseconds: 300),));
    }else if  (state is DashboardUpdateOGButtonErrorState) {

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(' update error ${state.error}')));
    }else if  (state is DashboardUpdateOGButtonLoadedSuccessState) {

      print('checking the state id value ${state.id}');
      switch(state.id){
        case null :
          addItem(state.userName!, state.userDescription!);

        default :
          updateItem(state.id!,state.userName!,state.userDescription!);
      }
    }
    // TODO: implement listener
  },
  builder: (context, state) {
        switch (state.runtimeType){
          case DashboardInitialLoadingState :
            return loadingIndicator(context)!;

          case DashboardInitialLoadedSuccessState :
            final successState = state as DashboardInitialLoadedSuccessState;

            _userList = state.userList;
            return Scaffold(
              appBar: AppBar(
                title: const Center(child: Text('SQL FLITE')),
              ),
              body:  ListView.builder(
                itemCount: _userList.length,
                itemBuilder: (context, index) => Card(
                    color: Theme.of(context).colorScheme.onPrimary,
                    elevation: 5,
                    margin: const EdgeInsets.all(15),
                    child: ExpansionTile(
                      leading: Icon(Icons.person,color: Theme.of(context).colorScheme.onSecondary,),
                      title:Text(_userList[index]['userName']),
                      children: [
                        ListTile(
                            title: Text(_userList[index]['userName']),
                            subtitle: Text(_userList[index]['userDescription']),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon:  Icon(Icons.edit,
                                      color: Theme.of(context).colorScheme.onSecondary,
                                    ),
                                    onPressed: () => dashboardBloc?.add(DashboardUpdateButtonEvent(id: _userList[index]['id'])),
                                  ),
                                  IconButton(
                                    icon:  Icon(Icons.delete,
                                      color: Theme.of(context).colorScheme.onTertiary,
                                    ),
                                    onPressed: () =>
                                        dashboardBloc?.add(DashboardDeleteButtonEvent(id: _userList[index]['id'])),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    )
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => dashboardBloc?.add(DashboardFloatingActionButtonEvent()),
              ),
            );

          case DashboardInitialErrorState :
            final errorState = state as DashboardInitialErrorState;
            return
               Scaffold(
                  body: Center(
                    child: Text('Error ${errorState.error}')
                  ));
          default:
            return const SizedBox();

        }
  },
);
  }
}