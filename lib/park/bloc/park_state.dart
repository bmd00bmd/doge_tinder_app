part of 'park_bloc.dart';

enum ParkStatus { initial, success, failure }

class ParkState extends Equatable {
  const ParkState({
    this.status = ParkStatus.initial,
    this.dogeImageUrls = const <String>[],
    this.hasReachedMax = false,
  });

  final ParkStatus status;
  final List<String> dogeImageUrls;
  final bool hasReachedMax;

  ParkState copyWith({
    ParkStatus? status,
    List<String>? dogeImageUrls,
    bool? hasReachedMax,
  }) {
    return ParkState(
      status: status ?? this.status,
      dogeImageUrls: dogeImageUrls ?? this.dogeImageUrls,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ParkState { status: $status, hasReachedMax: $hasReachedMax, dogeImageUrls: ${dogeImageUrls.length} }''';
  }

  @override
  List<Object> get props => [status, dogeImageUrls, hasReachedMax];
}
