class RegisterValidators {
  const RegisterValidators._();

  static String? validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return 'Name is required';
    if (name.length < 3) return 'Name must be at least 3 characters';
    if (name.length > 100) return 'Name must be at most 100 characters';
    return null;
  }

  static String? validateBusinessName(String? value) {
    final businessName = value?.trim() ?? '';
    if (businessName.isEmpty) return 'Business name is required';
    if (businessName.length < 3) {
      return 'Business name must be at least 3 characters';
    }
    if (businessName.length > 150) {
      return 'Business name must be at most 150 characters';
    }
    return null;
  }

  static String? validateMobileNumber(String? value) {
    final mobile = value?.trim() ?? '';
    if (mobile.isEmpty) return 'Mobile number is required';
    if (!RegExp(r'^\d{10}$').hasMatch(mobile)) {
      return 'Mobile number must be exactly 10 digits';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Email is required';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    if (password.length > 128) return 'Password must be at most 128 characters';
    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)').hasMatch(password)) {
      return 'Password must include letters and numbers';
    }
    return null;
  }
}
