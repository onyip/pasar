import 'package:equatable/equatable.dart';

class RegisterEven extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterStart extends RegisterEven {}

class RegisterAction extends RegisterEven {
  final String userFullname, email, phone, password;

  RegisterAction({this.userFullname, this.email, this.phone, this.password});
}
