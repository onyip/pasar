import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        backgroundColor: Colors.white,
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
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Text(
                                          "Welcome Back!",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 200,
                                        child: Image(
                                          image: NetworkImage(
                                              'https://as1.ftcdn.net/jpg/02/44/61/66/500_F_244616624_UcJucFEN467oUhqhHcBEhBYj7SKV2sFN.jpg'),
                                        ),
                                      ),

                                      // email
                                      Container(
                                        margin: EdgeInsets.all(8),
                                        child: TextFormField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                Icon(FontAwesomeIcons.envelope),
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
                                          obscureText: true,
                                          controller: _passwordController,
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                Icon(FontAwesomeIcons.lock),
                                          ),
                                          validator: (value) {
                                            if (_passwordController.text ==
                                                "") {
                                              return "Password wajib diisi";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        padding: EdgeInsets.only(
                                          right: 35,
                                          left: 35,
                                        ),
                                        width: double.infinity,
                                        child: RaisedButton(
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              BlocProvider.of<LoginBloc>(
                                                      context)
                                                  .add(LoginAction(
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text,
                                              ));
                                            }
                                          },
                                          color: Colors.blue[900],
                                          child: Text(
                                            "Masuk",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(30.0),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                        ),
                                        child: Text(
                                            "Atau masuk melalui sosial media"),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            RaisedButton(
                                              onPressed: () {},
                                              child: Icon(
                                                FontAwesomeIcons.facebookF,
                                                color: Colors.white,
                                              ),
                                              shape: CircleBorder(),
                                              color: Colors.blue[800],
                                            ),
                                            RaisedButton(
                                              onPressed: () {},
                                              child: Icon(
                                                FontAwesomeIcons.google,
                                                color: Colors.white,
                                              ),
                                              shape: CircleBorder(),
                                              color: Colors.red[800],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
