class Validator {
  static String? validateEmail(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex =  RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return '🚩 Please enter a valid email address.';
    } else {
      return null;
    }
  }

  static String? validateDropDefaultData(value) {
    if (value == null) {
      return 'Please select an item.';
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex =  RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return '🚩 Password must be at least 6 characters.';
    } else {
      return null;
    }
  }

  static String? validateName(String value) {
    if (value.length < 3) {
      return '🚩 Username is too short.';
    } else {
      return null;
    }
  }

  static String? validateFirstName(String value) {
    if (value.length < 3) {
      return '🚩 Invalid.';
    } else {
      return null;
    }
  }

  static String? validateLastName(String value) {
    if (value.length < 3) {
      return '🚩 Invalid.';
    } else {
      return null;
    }
  }

  static String? validateHeight(String value) {
    Pattern pattern = '\\d+(\\.\\d+)?';
    RegExp regex =  RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return '🚩 Invalid';
    } else {
      return null;
    }
  }

  static String? validateKilograms(String value) {
    Pattern pattern = '\\d+(\\.\\d+)?';
    RegExp regex =  RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return '🚩 Invalid';
    } else {
      return null;
    }
  }

  static String? validateBloodPressure(String value) {
    Pattern pattern = '\\d+(\\.\\d+)?';
    RegExp regex =  RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return '🚩 Invalid';
    } else {
      return null;
    }
  }


  static String? validatePhoneNumber(String value) {
    if (value.length != 10) {
      return '🚩 Phone number is not valid.';
    } else {
      return null;
    }
  }

}