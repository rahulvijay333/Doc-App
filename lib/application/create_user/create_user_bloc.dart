import 'package:appoint_medic/domain/new_user/new_user.dart';
import 'package:appoint_medic/infrastructure/register/register_impl.dart';
import 'package:bloc/bloc.dart';

part 'create_user_event.dart';
part 'create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  final CreateServiceImpl createServiceImpl;
  CreateUserBloc(this.createServiceImpl) : super(CreateUserInitial()) {
    on<CreateButtonClicked>((event, emit) async {
      //--------------------------------------------------initial loading
      emit(CreateUserLoading());

      final (error, response) = await createServiceImpl.createAccount(
          user: event.newUser, userType: event.userType);

      if (error.isEmpty) {
        //------------------------------------------account created sucess
        emit(CreateUserSuccess(
            email: event.newUser.email, userType: event.userType));
      } else {
        emit(CreateUserFailed(errorMessage: error));

        if (emit.isDone) {
          emit(CreateUserInitial());
        }
      }
    });

    on<InitialiCreateBloc>((event, emit) {
      emit(CreateUserInitial());
    });
  }
}
