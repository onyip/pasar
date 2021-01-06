import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasar/blocs/auth/auth_bloc.dart';
import 'package:pasar/blocs/auth/auth_even.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("selamat datang di pasar Online"),
          RaisedButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(AuthToLogout());
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
