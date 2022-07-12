import 'package:app_datn_2022/main.dart';
import 'package:app_datn_2022/model/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<SignInRequest>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signIn(emailSignIn: event.emailSignIn, passwordSignIn: event.passwordSignIn);
        myAppPreferences.setBool('logIn', true);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(error: e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<SignUpRequest>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signUp(emailSignUp: event.emailSignUp, passwordSignUp: event.passwordSignUp);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(error: e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<SignOutRequest>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signOut();
        myAppPreferences.setBool('logIn', false);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(error: e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<SignInWithGoogle>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signInWithGoogle();
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(error: e.toString()));
        emit(UnAuthenticated());
      }
    });
  }
}
