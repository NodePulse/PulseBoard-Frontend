class AppValidators {
  static String? required(String? value, {String fieldName = "Field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required.";
    }

    return null;
  }

  static String? email(String? value) {
    final requiredError = required(value, fieldName: "Email");

    if (requiredError != null) return requiredError;

    final emailRegex = RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
    );

    if (!emailRegex.hasMatch(value!.trim())) {
      return "Please enter a valid email address";
    }

    return null;
  }

  static String? password(String? value) {
    final requiredError = required(value, fieldName: "Password");

    if (requiredError != null) return requiredError;

    if (value!.length < 8) {
      return "Password must be at least 8 characters";
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Must contain one uppercase letter";
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Must contain one lowercase letter";
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Must contain one number";
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Must contain one special character";
    }

    return null;
  }
}
