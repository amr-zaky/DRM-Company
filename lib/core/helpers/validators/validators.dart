final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

final RegExp email2RegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

final RegExp phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{11}$)');

final RegExp emailStartsSpecial = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

final RegExp nameValidation = RegExp(r"^[\p{L} ,.'-]*$",
    caseSensitive: false, unicode: true, dotAll: true);
RegExp myRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9]");

RegExp passwordComplexValidation =
    RegExp(r"^((?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,40})");
RegExp hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

bool nameValidator(String name) {
  if (nameValidation.hasMatch(name)) {
    return false;
  } else {
    return true;
  }
}

bool complexValidationLowerAndUpperCaseValidator(String name) {
  if (passwordComplexValidation.hasMatch(name)) {
    return false;
  } else {
    return true;
  }
}

bool complexValidationSpecialCharactersValidator(String name) {
  if (hasSpecialCharacters.hasMatch(name)) {
    return false;
  } else {
    return true;
  }
}

/// Email Validation
bool emailValidator(String email) {
  if (email.isEmpty) {
    return false;
  } else if (!emailRegExp.hasMatch(email)) {
    return false;
  } else {
    return true;
  }
}

/// Phone Number Validation
bool phoneValidator(String phoneNumber) {
  if (phoneNumber.isEmpty) {
    return false;
  } else if (!phoneRegExp.hasMatch(phoneNumber)) {
    return false;
  } else {
    return true;
  }
}

/// Phone Validation
bool validatePhone(String phone) {
  if (phone.isEmpty) {
    return false;
  }
  if (phone.length < 11) {
    return false;
  }
  if (!phoneRegExp.hasMatch(phone)) {
    return false;
  }
  return true;
}

/// Email Validation
bool validateEmail(String email) {
  if (email.isEmpty) {
    return false;
  } else if (!emailRegExp.hasMatch(email)) {
    return false;
  } else if (!email.startsWith(myRegExp)) {
    return false;
  } else {
    return true;
  }
}

/// Password Validation
bool validatePassword(String password) {
  if (password.isEmpty) {
    return false;
  }
  if (password.length < 6) {
    return false;
  }
  return true;
}
