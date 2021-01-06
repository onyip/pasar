import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasar/blocs/auth/auth_bloc.dart';
import 'package:pasar/blocs/auth/auth_even.dart';
import 'package:pasar/blocs/auth/auth_state.dart';
import 'package:pasar/services/auth/auth_service.dart';
import 'package:pasar/ui/auth/login_page.dart';
import 'package:pasar/ui/auth/register_page.dart';
import 'package:pasar/ui/auth/spalsh_page.dart';
import 'package:pasar/ui/auth/welcome_page.dart';
import 'package:pasar/ui/home/home_page.dart';

void main() {
  // runApp(MyApp());
  AuthService authService = new AuthService();
  runApp(
    BlocProvider<AuthBloc>(
      create: (context){
        return AuthBloc(
          initialState: AuthInitialized(),
          authService: authService,
        )..add(AuthStart());
      },
      child: MyApp(
        authService: authService,
      ),
    )
  );
}

class MyApp extends StatelessWidget {
  final AuthService authService;

  const MyApp({Key key, this.authService}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pasar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state){
        if (state is AuthUnauthorized) {
          return WelcomePage();
        }

        if (state is AuthAuthorized) {
          return HomePage();
        }

        if (state is AuthLogin) {
          return LoginPage(
            authService: authService,
          );
        }

        if (state is AuthRegister) {
          return RegisterPage(
            authService: authService,
          );
        }
        return SpalshPage();
      },
      ),
    );
  }
}
