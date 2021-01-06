import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  @override
  List<Object> get props => [];
  
}

class LoginInitializ extends LoginState {
  
}

class LoginLoading extends LoginState {
  
}

class LoginFailur extends LoginState {
final String massage;

LoginFailur({this.massage});
}