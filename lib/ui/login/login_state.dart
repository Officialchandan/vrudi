import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  List<Object?> get props => [];
}

class GetLoginState extends LoginState {
  final message;
  GetLoginState(this.message);

  @override
  List<Object> get props => [message];
}

class LoadingState extends LoginState {
  LoadingState();
  @override
  List<Object?> get props => [];
}

class GetLoginFailureState extends LoginState {
  final String message;
  GetLoginFailureState({required this.message});
  @override
  List<Object?> get props => [message];
}
