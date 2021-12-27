import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:doge_tinder_app/core/api/doge_api.dart';
import 'package:doge_tinder_app/core/core.dart';
import 'package:doge_tinder_app/house/bloc/house_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:http/http.dart' as http;
part 'park_event.dart';
part 'park_state.dart';

const _imageLimit = 15;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ParkBloc extends Bloc<ParkEvent, ParkState> {
  ParkBloc() : super(const ParkState()) {
    on<ParkDogeArrival>(
      _onParkDogeArrival,
      transformer: throttleDroppable(
        throttleDuration,
      ),
    );
    on<DogeDecision>(_onDogeDecision);
  }

  DogeApi api = new DogeApi(httpClient: http.Client());

  Future<void> _onParkDogeArrival(
      ParkDogeArrival event, Emitter<ParkState> emit) async {
    if (state.hasReachedMax) return;
    try {
      print('Initial park bloc status...');
      final imageList = List<String>.from(
          (await api.fetchRandomDogeImages(_imageLimit))['message']);
      emit(state.copyWith(
        status: ParkStatus.success,
        dogeImageUrls: imageList,
        hasReachedMax: false,
      ));
    } catch (_) {
      emit(state.copyWith(status: ParkStatus.failure));
    }
  }

  Future<void> _onDogeDecision(
      DogeDecision event, Emitter<ParkState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final _savedDogs = prefs.getString(AppKeys.dogeTinderStoreFileKey);
      print(_savedDogs);
      List<String> _allDoges = [];
      if (_savedDogs != null) {
        _allDoges.addAll(
          List<String>.from(
            json.decode(_savedDogs),
          ),
        );
        print(_allDoges);
      }
      if (event.decision == true) {
        print('Save this doge to your house file.');
        _allDoges.add(event.imageUrl);
        prefs.setString(
          AppKeys.dogeTinderStoreFileKey,
          json.encode(_allDoges),
        );
      } else {
        print('We don\'t want this doge.');
        print(event.imageUrl);
        final removed = _allDoges.remove(event.imageUrl);
        if (removed) {
          prefs.setString(
            AppKeys.dogeTinderStoreFileKey,
            json.encode(_allDoges),
          );
        }
      }
    } catch (_) {
      emit(state.copyWith(status: ParkStatus.failure));
    }
  }
}
