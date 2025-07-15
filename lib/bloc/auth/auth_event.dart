abstract class AuthEvent {
  const AuthEvent();
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const RegisterRequested({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}
