import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../services/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final uid = await authService.loginUser(
          email: event.email,
          password: event.password,
        );

        emit(Authenticated(uid));
      } catch (e) {
        emit(AuthError('Login fehlgeschlagen: ${e.toString()}'));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final uid = await authService.registerUser(
          email: event.email,
          password: event.password,
          firstName: event.firstName,
          lastName: event.lastName,
        );
        emit(Authenticated(uid));
      } catch (e) {
        emit(AuthError('Registrierung fehlgeschlagen: ${e.toString()}'));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await authService.logout();
      emit(Unauthenticated());
    });
  }
}
