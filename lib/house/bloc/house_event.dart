part of 'house_bloc.dart';

abstract class HouseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WelcomeHome extends HouseEvent {}

class AddDogeToHouse extends HouseEvent {
  AddDogeToHouse(this.imageUrl);
  final String imageUrl;
}

class RemoveDogeFromHouse extends HouseEvent {
  RemoveDogeFromHouse(this.imageUrl);
  final String imageUrl;
}
