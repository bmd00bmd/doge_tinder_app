part of 'park_bloc.dart';

abstract class ParkEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ParkDogeArrival extends ParkEvent {}

class DogeDecision extends ParkEvent {
  DogeDecision({this.imageUrl = '', this.decision = false});
  final String imageUrl;
  final bool decision;
}
