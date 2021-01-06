import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasar/blocs/auth/auth_bloc.dart';
import 'package:pasar/blocs/auth/auth_even.dart';
import 'package:pasar/blocs/login/login_even.dart';
import 'package:pasar/blocs/login/login_state.dart';
import 'package:pasar/models/auth/login_model.dart';
import 'package:pasar/services/auth/auth_service.dart';

class LoginBloc extends Bloc<LoginEven, LoginState> {
  final AuthBloc authBloc;
  final AuthService authService;

  LoginBloc({
    LoginState initialState,
    this.authBloc,
    this.authService,
  }) : super(initialState);
  @override
  Stream<LoginState> mapEventToState(LoginEven event) async* {
    if (event is LoginStart) {
      yield LoginInitializ();
    }

    if (event is LoginAction) {
      yield LoginLoading();
      try {
        final LoginModel loginModel = await authService.login(
          email: event.email,
          password: event.password,
        );

        if (loginModel.status == false) {
          yield LoginFailur(
            massage: loginModel.message,
          );
        }else{
          // simpan
          await authService.presistUserId(
            userId: loginModel.data.userId,
          );

          await authService.presistAccsessToken(
            accessToken: loginModel.data.accessToken,
          );
          // ubah status login
          authBloc.add(AuthSuccessLogin());
        }
      } catch (e) {
        yield LoginFailur(massage: "Gagal Login");
      }
    }
  }
}
