import 'package:bloc/bloc.dart';
import 'package:doge_tinder_app/tabs/bloc/tab_event.dart';
import 'package:doge_tinder_app/tabs/models/app_tab.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.park) {
    on<TabUpdated>(_onTabUpdated);
  }

  Future<void> _onTabUpdated(TabUpdated event, Emitter<AppTab> emit) async {
    return emit(event.tab);
  }
}
