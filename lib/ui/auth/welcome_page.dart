import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasar/blocs/auth/auth_bloc.dart';
import 'package:pasar/blocs/auth/auth_even.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white70,
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  child: Image(
                    image: NetworkImage(
                        'https://as1.ftcdn.net/jpg/02/44/61/66/500_F_244616624_UcJucFEN467oUhqhHcBEhBYj7SKV2sFN.jpg'),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "Selamat Datang Di",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      child: Text(
                        "SIMBOK BLONJO",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Dinas Perindustrian dan Perdagangan",
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Kabupaten Kebumen",
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: RaisedButton(
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(AuthToRegister());
                        },
                        padding: EdgeInsets.only(
                          left: 50,
                          right: 50,
                        ),
                        color: Colors.blue[900],
                        child: Text(
                          'Daftar',
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    Container(
                      child: OutlineButton(
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(AuthToLogin());
                        },
                        borderSide: BorderSide(
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        padding: EdgeInsets.only(
                          left: 50,
                          right: 50,
                        ),
                        child: Text('Masuk'),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
