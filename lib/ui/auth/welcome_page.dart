import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasar/blocs/auth/auth_bloc.dart';
import 'package:pasar/blocs/auth/auth_even.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(margin: EdgeInsets.only(top: 20),
              child: Text("Selamat Datang Di", style: TextStyle(fontSize: 20),),
            ),

            Container(
              child: Text(
                "SIMBOK BLONJO",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            
            Expanded(child: Icon(Icons.add_shopping_cart)),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(AuthToRegister());
                      },
                      child: Text('Daftar'),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(AuthToLogin());
                      },
                      child: Text('Masuk'),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
