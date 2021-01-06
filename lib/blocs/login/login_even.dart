import 'package:equatable/equatable.dart';

class LoginEven extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginStart extends LoginEven {}

class LoginAction extends LoginEven {
  final String email, password;

  LoginAction({this.email, this.password});
}
