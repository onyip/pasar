import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasar/blocs/auth/auth_bloc.dart';
import 'package:pasar/blocs/auth/auth_even.dart';
import 'package:pasar/blocs/register/register_even.dart';
import 'package:pasar/blocs/register/register_state.dart';
import 'package:pasar/models/auth/register_model.dart';
import 'package:pasar/services/auth/auth_service.dart';

class RegisterBloc extends Bloc<RegisterEven, RegisterState> {
  final AuthBloc authBloc;
  final AuthService authService;

  RegisterBloc({
    RegisterState initialState,
    this.authBloc,
    this.authService,
  }) : super(initialState);
  @override
  Stream<RegisterState> mapEventToState(RegisterEven event) async* {
    if (event is RegisterStart) {
      yield RegisterInitializ();
    }

    if (event is RegisterAction) {
      yield RegisterLoading();

      try {
        final RegisterModel registerModel = await authService.register(
          userFullname: event.userFullname,
          email: event.email,
          phone: event.phone,
          password: event.password,
        );

        if (registerModel.status == false) {
          yield RegisterFailur(massage: registerModel.message);
        } else {
          // menyimpan user id
          await authService.presistUserId(
            userId: registerModel.data.userId,
          );
          await authService.presistAccsessToken(
            accessToken: registerModel.data.accessToken,
          );

          authBloc.add(AuthSuccessRegister());
        }
      } catch (e) {}
    }
  }
}
