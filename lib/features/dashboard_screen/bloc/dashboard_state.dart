part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

abstract class DashboardActionState extends DashboardState {}

class DashboardInitialLoadingState extends DashboardState {}

class DashboardInitialLoadedSuccessState extends DashboardState {
  final  List<Map<String, dynamic>> userList  ;
  DashboardInitialLoadedSuccessState({required this.userList, });
}

class DashboardInitialErrorState extends DashboardState {
  final String? error;
  DashboardInitialErrorState({required this.error});
}


class DashboardFloatingActionButtonLoadingState extends DashboardActionState {}

class DashboardFloatingActionButtonLoadedSuccessState extends DashboardActionState {
  // final String qrCode;
  // BarCodeAddingButtonLoadedSuccessState({required this.qrCode});
}

class DashboardFloatingActionButtonErrorState extends DashboardActionState {
  final String error;
  DashboardFloatingActionButtonErrorState({required this.error});
}

class DashboardDeleteButtonLoadingState extends DashboardActionState {}

class DashboardDeleteButtonLoadedSuccessState extends DashboardActionState {
  final int? id;
  DashboardDeleteButtonLoadedSuccessState({required this.id});
}

class DashboardDeleteButtonErrorState extends DashboardActionState {
  final String error;
  DashboardDeleteButtonErrorState({required this.error});
}


class DashboardUpdateButtonLoadingState extends DashboardActionState {}

class DashboardUpdateButtonLoadedSuccessState extends DashboardActionState {
  final int? id;
  final String? userName;
  final String? userDescription;
  DashboardUpdateButtonLoadedSuccessState({required this.id, this.userName, this.userDescription});
}

class DashboardUpdateButtonErrorState extends DashboardActionState {
  final String error;
  DashboardUpdateButtonErrorState({required this.error});
}

class DashboardUpdateOGButtonLoadingState extends DashboardActionState {}

class DashboardUpdateOGButtonLoadedSuccessState extends DashboardActionState {
  final int? id;
  final String? userName;
  final String? userDescription;
  DashboardUpdateOGButtonLoadedSuccessState({required this.id, this.userName, this.userDescription});
}

class DashboardUpdateOGButtonErrorState extends DashboardActionState {
  final String error;
  DashboardUpdateOGButtonErrorState({required this.error});
}
