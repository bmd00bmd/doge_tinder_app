import 'dart:convert';
import 'package:doge_tinder_app/core/core.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:doge_tinder_app/core/api/doge_api.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
part 'house_event.dart';
part 'house_state.dart';

class HouseBloc extends Bloc<HouseEvent, HouseState> {
  HouseBloc() : super(const HouseState()) {
    on<AddDogeToHouse>(_onAddDogeToHouse);
    on<RemoveDogeFromHouse>(_onRemoveDogeFromHouse);
    on<WelcomeHome>(_onWelcomeHome);
  }

  Future<void> _onWelcomeHome(
      WelcomeHome event, Emitter<HouseState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      String? _savedDogs = prefs.getString(AppKeys.dogeTinderStoreFileKey);
      print(_savedDogs);
      List<String> _allDoges = [];
      if (_savedDogs != null) {
        _allDoges.addAll(
          List<String>.from(
            json.decode(_savedDogs),
          ),
        );
      }
      emit(
        state.copyWith(
          status: HouseStatus.happy,
          doges: _allDoges,
          hasReachedMax: false,
        ),
      );
    } catch (_) {
      prefs.remove(AppKeys.dogeTinderStoreFileKey);
      emit(
        state.copyWith(
          status: HouseStatus.destroyed,
        ),
      );
    }
  }

  Future<void> _onAddDogeToHouse(
      AddDogeToHouse event, Emitter<HouseState> emit) async {
    if (state.hasReachedMax) return;
    final prefs = await SharedPreferences.getInstance();
    try {
      List<String> _allDogs = state.doges;
      _allDogs.add(event.imageUrl);
      prefs.setString(
        AppKeys.dogeTinderStoreFileKey,
        json.encode(
          _allDogs,
        ),
      );
      emit(
        state.copyWith(
          status: HouseStatus.happy,
          doges: _allDogs,
          hasReachedMax: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: HouseStatus.destroyed));
    }
  }

  Future<void> _onRemoveDogeFromHouse(
      RemoveDogeFromHouse event, Emitter<HouseState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> _allDogs = state.doges;
      _allDogs.remove(event.imageUrl);
      prefs.setString(AppKeys.dogeTinderStoreFileKey, _allDogs.toString());
      emit(
        state.copyWith(
          status: HouseStatus.happy,
          doges: _allDogs,
          hasReachedMax: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: HouseStatus.destroyed));
    }
  }
}
