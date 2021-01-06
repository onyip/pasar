import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  @override
  List<Object> get props => [];
  
}
class AuthInitialized extends AuthState {
  
}

class AuthUnauthorized extends AuthState{
  
}

class AuthAuthorized extends AuthState{
  
}

class AuthLogin extends AuthState{
  
}

class AuthRegister extends AuthState{
  
}