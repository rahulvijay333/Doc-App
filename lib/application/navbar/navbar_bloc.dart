import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(NavbarState(pageIndex: 0)) {
    on<PageChangeEvent>((event, emit) {
      emit(NavbarState(pageIndex: event.page));
    });
  }
}
