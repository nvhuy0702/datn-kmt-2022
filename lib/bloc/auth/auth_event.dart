part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpRequest extends AuthEvent {
  final String emailSignUp;
  final String passwordSignUp;
  SignUpRequest(this.emailSignUp, this.passwordSignUp);
}
class SignInRequest extends AuthEvent {
  final String emailSignIn;
  final String passwordSignIn;
  SignInRequest(this.emailSignIn, this.passwordSignIn);
}
class SignOutRequest extends AuthEvent {}
class SignInWithGoogle extends AuthEvent {}


