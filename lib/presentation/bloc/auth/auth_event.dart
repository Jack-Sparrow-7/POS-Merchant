abstract class AuthEvent {
  const AuthEvent();
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({required this.email, required this.password});
}

class AuthRegisterRequested extends AuthEvent {
  final String name;
  final String businessName;
  final String mobileNumber;
  final String email;
  final String password;

  const AuthRegisterRequested({
    required this.name,
    required this.businessName,
    required this.mobileNumber,
    required this.email,
    required this.password,
  });
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthCurrentUserRequested extends AuthEvent {
  const AuthCurrentUserRequested();
}
