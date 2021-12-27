import 'package:equatable/equatable.dart';

class DogeEntity extends Equatable {
  const DogeEntity({
    required this.id,
    required this.breed,
    required this.subBreed,
    required this.imgUrl,
  });

  final String id;
  final String breed;
  final String subBreed;
  final String imgUrl;

  @override
  List<Object> get props => [id, breed, subBreed, imgUrl];

  @override
  String toString() =>
      'DogeEntity { id: $id, breed: $breed, subBreed: $subBreed, imgUrl: $imgUrl }';
}
