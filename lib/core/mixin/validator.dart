mixin Validator {
  String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Enter a valid Email';
    } else {
      bool isValidEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+", caseSensitive: false).hasMatch(email);
      if (isValidEmail) {
        return null;
      } else {
        return 'Enter a valid Email';
      }
    }
  }

  String? validateUsername(String? username) {
    if (username!.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? validateFirstName(String? name) {
    if (name!.isEmpty) {
      return 'First Name is required';
    }
    return null;
  }

  String? validateLastName(String? surname) {
    if (surname!.isEmpty) {
      return 'Last Name is required';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return 'Password is required';
    } else if (password.length < 8) {
      return 'Password length must be 8 character long';
    }
    return null;
  }

  bool validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty || phoneNumber.length < 11 || phoneNumber.length > 11) {
      return false;
    }
    return true;
  }

  String? validateHowMuch(String? value) {
    if (value!.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? validateWhoReferredYou(String? value) {
    if (value!.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? validateRefFirstName(String? value) {
    if (value!.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? validateRefLastName(String? value) {
    if (value!.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
