class Validators {
  /// Validate first name
  static String? validateFirstName(String value) {
    if (value.trim().isEmpty) {
      return 'Please enter first name';
    }

    final pattern = RegExp(r'^[A-Za-z]+$');
    if (!pattern.hasMatch(value.trim())) {
      return 'Only letters are allowed in first name';
    }
    if (value.trim().length < 2) {
      return 'First name must be at least 2 characters';
    }
    if (value.trim().length > 50) {
      return 'First name is too long';
    }

    return null;
  }

  /// Validate last name (optional)
  static String? validateLastName(String value) {
    if (value.trim().isEmpty) {
      return null; // ✅ optional
    }

    final pattern = RegExp(r'^[A-Za-z]+$');
    if (!pattern.hasMatch(value.trim())) {
      return 'Only letters are allowed in last name';
    }
    if (value.trim().length > 50) {
      return 'Last name is too long';
    }

    return null;
  }

  /// Validate email
  static String? validateEmail(String value) {
    if (value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Validate phone (optional)
  static String? validatePhone(String value) {
    if (value.trim().isEmpty) return null; // ✅ optional

    final phoneRegex = RegExp(r'^[0-9]{10}$'); // exactly 10 digits
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Please enter a valid 10-digit phone number';
    }

    return null;
  }

  /// Validate password
  static String? validatePassword(String value) {
    if (value.isEmpty) return 'Password is required';
    final regex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$%^&*(),.?":{}|<>]).{8,}$',
    );
    if (!regex.hasMatch(value)) {
      return 'Password does not meet requirements';
    }
    return null;
  }

  /// Validate login password
  static String? validateLoginPassword(String value) {
    if (value.isEmpty) return 'Password is required';
    return null;
  }
}
