import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habito/bloc/user/user_event.dart';
import 'package:habito/bloc/user/user_state.dart';

import 'package:habito/services/auth_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthService authService;

  UserBloc(this.authService) : super(UserInitial()) {
    on<LoadUserData>((event, emit) async {
      emit(UserLoading());
      try {
        final doc = await authService.getUserData(event.uid);
        emit(
          UserLoaded(
            firstName: doc['firstName'] as String? ?? '',
            lastName: doc['lastName'] as String? ?? '',
            email: doc['email'] as String? ?? '',
          ),
        );
      } catch (e) {
        emit(UserError('Benutzerdaten konnten nicht geladen werden.'));
      }
    });
  }
}
