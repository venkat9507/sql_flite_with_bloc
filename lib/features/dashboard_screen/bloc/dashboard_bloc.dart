import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/user_data.dart';
import '../view/bottom_sheet.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardInitialEvent>(dashboardInitialEvent);
    on<DashboardFloatingActionButtonEvent>(dashboardFloatingActionButtonEvent);
    on<DashboardDeleteButtonEvent>(dashboardDeleteButtonEvent);
    on<DashboardUpdateButtonEvent>(dashboardUpdateButtonEvent);
    on<DashboardUpdateOGButtonEvent>(dashboardUpdateOGButtonEvent);

  }

  Future<FutureOr<void>> dashboardInitialEvent(DashboardInitialEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardInitialLoadingState());

    try {
    await   refreshJournals(); // Loading the diary when the app starts
    await Future.delayed(const Duration(seconds: 3));
      emit(DashboardInitialLoadedSuccessState(
        userList: userList
      ));
    }
    catch (e) {
      emit(DashboardInitialErrorState(error: 'Dashboard Screen ${e.toString()}'));
    }

  }

  Future<FutureOr<void>> dashboardFloatingActionButtonEvent(DashboardFloatingActionButtonEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardFloatingActionButtonLoadingState());

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      emit(DashboardFloatingActionButtonLoadedSuccessState(

      ));
    }
    catch (e) {
      emit(DashboardFloatingActionButtonErrorState(error: ' Floating Action button  Error ${e.toString()}'));
    }


  }

  Future<FutureOr<void>> dashboardDeleteButtonEvent(DashboardDeleteButtonEvent event, Emitter<DashboardState> emit) async {

    emit(DashboardDeleteButtonLoadingState());

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      emit(DashboardDeleteButtonLoadedSuccessState(id: event.id!,
      ));
      await   refreshJournals(); // Loading the diary when the app starts
      await Future.delayed(const Duration(milliseconds: 100));
      emit(DashboardInitialLoadedSuccessState(
          userList: userList
      ));
    }
    catch (e) {
      emit(DashboardFloatingActionButtonErrorState(error: ' Floating Action button  Error ${e.toString()}'));
    }

  }

  Future<FutureOr<void>> dashboardUpdateButtonEvent(DashboardUpdateButtonEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardUpdateButtonLoadingState());

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      emit(DashboardUpdateButtonLoadedSuccessState(id: event.id!,
        // userName: event.userName!,userDescription: event.userDescription!,
      ));
      await   refreshJournals(); // Loading the diary when the app starts
      await Future.delayed(const Duration(milliseconds: 100));
      emit(DashboardInitialLoadedSuccessState(
          userList: userList
      ));
    }
    catch (e) {
      emit(DashboardFloatingActionButtonErrorState(error: ' Floating Action button  Error ${e.toString()}'));
    }
  }

  Future<FutureOr<void>> dashboardUpdateOGButtonEvent(DashboardUpdateOGButtonEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardUpdateOGButtonLoadingState());

    try {
      await Future.delayed(const Duration(milliseconds: 100));
      emit(DashboardUpdateOGButtonLoadedSuccessState(id: event.id,
        userName: event.userName!,userDescription: event.userDescription!,
      ));
      await   refreshJournals(); // Loading the diary when the app starts
      await Future.delayed(const Duration(milliseconds: 50));
      emit(DashboardInitialLoadedSuccessState(
          userList: userList
      ));
    }
    catch (e) {
      emit(DashboardFloatingActionButtonErrorState(error: ' Floating Action button  Error ${e.toString()}'));
    }
  }
}
