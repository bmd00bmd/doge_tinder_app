import 'package:equatable/equatable.dart';

class DogeBreed extends Equatable {
  const DogeBreed({required this.name, this.subBreedNames = const []});
  final String name;
  final List<String> subBreedNames;

  @override
  List<Object> get props => [name, subBreedNames];

  @override
  String toString() =>
      'DogeBreed { name: $name, subBreedNames: $subBreedNames }';
}
