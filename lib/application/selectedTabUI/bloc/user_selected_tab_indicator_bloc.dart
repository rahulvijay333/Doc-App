import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_selected_tab_indicator_event.dart';
part 'user_selected_tab_indicator_state.dart';

class UserSelectedTabIndicatorBloc
    extends Bloc<UserSelectedTabIndicatorEvent, UserSelectedTabIndicatorState> {
  UserSelectedTabIndicatorBloc()
      : super(UserSelectedTabIndicatorState(isSelected: false)) {
    on<SelectSlotIndicator>((event, emit) {
      // emit()
    });
  }
}
