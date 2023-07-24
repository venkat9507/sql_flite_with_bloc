part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class DashboardInitialEvent extends DashboardEvent {
  // final int? sectionID ;
  // DashboardInitialEvent({this.sectionID});
}


class DashboardFloatingActionButtonEvent extends DashboardEvent {
  // final int? sectionID;
  // final int? videoCatID;
  // final String? title;
  // LkgNavigateButtonEvent({this.sectionID,this.videoCatID,this.title});

}

class DashboardDeleteButtonEvent extends DashboardEvent {
  final int? id;
  // final int? videoCatID;
  // final String? title;
  DashboardDeleteButtonEvent({this.id,});

}

class DashboardUpdateButtonEvent extends DashboardEvent {
  final int? id;
  final String? userName;
  final String? userDescription;
  DashboardUpdateButtonEvent({this.id,this.userDescription,this.userName});

}

class DashboardUpdateOGButtonEvent extends DashboardEvent {
  final int? id;
  final String? userName;
  final String? userDescription;
  DashboardUpdateOGButtonEvent({this.id,this.userDescription,this.userName});

}
