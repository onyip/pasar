import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasar/blocs/auth/auth_bloc.dart';
import 'package:pasar/blocs/auth/auth_even.dart';
import 'package:pasar/blocs/login/login_bloc.dart';
import 'package:pasar/blocs/login/login_even.dart';
import 'package:pasar/blocs/login/login_state.dart';
import 'package:pasar/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final AuthService authService;

  const LoginPage({Key key, this.authService}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();

  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<AuthBloc>(context).add(AuthToWelcome());
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocProvider(
            create: (context) {
              return LoginBloc(
                initialState: LoginInitializ(),
                authBloc: BlocProvider.of<AuthBloc>(context),
                authService: widget.authService,
              )..add(
                  LoginStart(),
                );
            },
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginFailur) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('${state.massage}'),
                  ));
                }
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [

                                // email

                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                      hintText: 'example@gmail.com',
                                    ),
                                    validator: (value) {
                                      if (_emailController.text == "") {
                                        return "Email wajib diisi";
                                      }
                                      Pattern pattern =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value))
                                        return 'Email tidak valid!';
                                      return null;
                                    },
                                  ),
                                ),
                                // password
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      hintText: '',
                                    ),
                                    validator: (value) {
                                      if (_passwordController.text == "") {
                                        return "Password wajib diisi";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                BlocProvider.of<LoginBloc>(context)
                                    .add(LoginAction(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ));
                              }
                            },
                            child: Text("Masuk"),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
