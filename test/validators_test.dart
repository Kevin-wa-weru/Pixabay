import 'package:flutter_test/flutter_test.dart';
import 'package:web_challenge/utils/form_validators.dart';

void main() {
  group("Name Validator", () {
    test("Empty name returns error", () {
      expect(Validators.validateName(""), "Enter full name");
    });

    test("Valid name returns null", () {
      expect(Validators.validateName("Alice"), null);
    });
  });

  group("Email Validator", () {
    test("Empty email returns error", () {
      expect(Validators.validateEmail(""), "Enter email");
    });

    test("Invalid email returns error", () {
      expect(Validators.validateEmail("not-an-email"), "Enter valid email");
    });

    test("Valid email returns null", () {
      expect(Validators.validateEmail("test@example.com"), null);
    });
  });

  group("Password Validator", () {
    test("Empty password returns error", () {
      expect(Validators.validatePassword(""), "Enter password");
    });

    test("Short password returns error", () {
      expect(
        Validators.validatePassword("123"),
        "Password must be at least 6 chars",
      );
    });

    test("Valid password returns null", () {
      expect(Validators.validatePassword("123456"), null);
    });
  });

  group("Confirm Password Validator", () {
    test("Passwords do not match returns error", () {
      expect(
        Validators.validateConfirmPassword("12345", "123456"),
        "Passwords do not match",
      );
    });

    test("Matching passwords return null", () {
      expect(
        Validators.validateConfirmPassword("secret123", "secret123"),
        null,
      );
    });
  });

  group("Category Validator", () {
    test("Null category returns error", () {
      expect(Validators.validateCategory(null), "Select a category");
    });

    test("Valid category returns null", () {
      expect(Validators.validateCategory("Sports"), null);
    });
  });
}
