import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String email;
  final String password;

  User({required this.username, required this.email, required this.password});

  @override
  List<Object> get props => [username, email, password];
}
