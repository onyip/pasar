import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
  
}

class RegisterInitializ extends RegisterState {
  
}

class RegisterLoading extends RegisterState {
  
}

class RegisterFailur extends RegisterState {
final String massage;

RegisterFailur({this.massage});
}

