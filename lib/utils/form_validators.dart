
class Validators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return "Enter full name";
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Enter email";
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Enter valid email";
    }
    return null;
  }

  static String? validateCategory(String? value) {
    if (value == null) return "Select a category";
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Enter password";
    if (value.length < 6) return "Password must be at least 6 chars";
    return null;
  }

  static String? validateConfirmPassword(
      String? value, String originalPassword) {
    if (value != originalPassword) return "Passwords do not match";
    return null;
  }
}
