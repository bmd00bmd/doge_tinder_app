part of 'house_bloc.dart';

enum HouseStatus { happy, full, empty, dirty, destroyed }

class HouseState extends Equatable {
  const HouseState({
    this.status = HouseStatus.empty,
    this.doges = const <String>[],
    this.hasReachedMax = false,
  });

  final HouseStatus status;
  final List<String> doges;
  final bool hasReachedMax;

  HouseState copyWith({
    HouseStatus? status,
    List<String>? doges,
    bool? hasReachedMax,
  }) {
    return HouseState(
      status: status ?? this.status,
      doges: doges ?? this.doges,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''HouseState { status: $status, hasReachedMax: $hasReachedMax, doges: ${doges.length} }''';
  }

  @override
  List<Object> get props => [status, doges, hasReachedMax];
}
