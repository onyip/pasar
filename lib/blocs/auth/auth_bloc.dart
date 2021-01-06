import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasar/blocs/auth/auth_even.dart';
import 'package:pasar/blocs/auth/auth_state.dart';
import 'package:pasar/services/auth/auth_service.dart';

class AuthBloc extends Bloc<AuthEven, AuthState> {
  final AuthService authService;
  AuthBloc({AuthState initialState, this.authService}) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEven event) async* {
    if (event is AuthStart) {
      if (await authService.readAccessToken() != null) {
        yield AuthAuthorized();
      } else {
        yield AuthUnauthorized();
      }
    }

    if (event is AuthToWelcome) {
      yield AuthUnauthorized();
    }

    if (event is AuthToRegister) {
      yield AuthRegister();
    }

    if (event is AuthToLogin) {
      yield AuthLogin();
    }

    if (event is AuthSuccessRegister) {
      yield AuthAuthorized();
    }

    if (event is AuthSuccessLogin) {
      yield AuthAuthorized();
    }

    if (event is AuthToLogout) {
      await authService.deleteUserId();
      await authService.deleteAccessToken();
      yield AuthUnauthorized();
    }
  }
}
