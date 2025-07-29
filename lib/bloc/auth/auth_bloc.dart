import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habito/bloc/auth/auth_event.dart';
import 'package:habito/bloc/auth/auth_state.dart';
import 'package:habito/services/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(const AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(const AuthLoading());
      try {
        final uid = await authService.loginUser(
          email: event.email,
          password: event.password,
        );
        emit(Authenticated(uid));
      } catch (e) {
        emit(AuthError(e.toString().replaceFirst('Exception: ', '')));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(const AuthLoading());
      try {
        final uid = await authService.registerUser(
          email: event.email,
          password: event.password,
          firstName: event.firstName,
          lastName: event.lastName,
        );
        emit(Authenticated(uid));
      } catch (e) {
        emit(AuthError(e.toString().replaceFirst('Exception: ', '')));
      }
    });

    on<LogoutRequested>((event, emit) async {
      try {
        await authService.logout();
        emit(const Unauthenticated());
      } catch (e) {
        emit(const AuthError('Fehler beim Ausloggen'));
      }
    });
  }
}
