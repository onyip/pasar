import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasar/blocs/auth/auth_bloc.dart';
import 'package:pasar/blocs/auth/auth_even.dart';
import 'package:pasar/blocs/register/register_bloc.dart';
import 'package:pasar/blocs/register/register_even.dart';
import 'package:pasar/blocs/register/register_state.dart';
import 'package:pasar/services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final AuthService authService;

  const RegisterPage({Key key, this.authService}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = new GlobalKey<FormState>();

  final _userFullnameController = new TextEditingController();
  final _emailController = new TextEditingController();
  final _phoneController = new TextEditingController();
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
              return RegisterBloc(
                initialState: RegisterInitializ(),
                authBloc: BlocProvider.of<AuthBloc>(context),
                authService: widget.authService,
              )..add(
                  RegisterStart(),
                );
            },
            child: BlocListener<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state is RegisterFailur) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('${state.massage}'),
                  ));
                }
              },
              child: BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // fullname
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: TextFormField(
                                    controller: _userFullnameController,
                                    decoration: InputDecoration(
                                      labelText: "Full Name",
                                      hintText: 'e.g Jon Doeh',
                                    ),
                                    validator: (value) {
                                      if (_userFullnameController.text == "") {
                                        return "Nama wajib diisi";
                                      }
                                      return null;
                                    },
                                  ),
                                ),

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

                                // phone
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: TextFormField(
                                    controller: _phoneController,
                                    decoration: InputDecoration(
                                      labelText: "No HP",
                                      hintText: '085712748576',
                                    ),
                                    validator: (value) {
                                      if (_phoneController.text == "") {
                                        return "Nomor HP wajib diisi";
                                      }
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
                                BlocProvider.of<RegisterBloc>(context)
                                    .add(RegisterAction(
                                  userFullname: _userFullnameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  password: _passwordController.text,
                                ));
                              }
                            },
                            child: Text("Daftar"),
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
