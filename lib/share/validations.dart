class Validation {
  static validatePhone(String phone) {
    if (phone == null || phone.length < 9 || phone.length > 13) return false;
    final regexPhone = RegExp(r'^[0-9]+$');
    return regexPhone.hasMatch(phone);
  }

  static validateUsername(String username) {
    if (username == null) return false;
    if (username.isEmpty || username.trim().length <1 || username.trim().length >50) return false;
    return true;
  }

  static validatePass(String password) {
    if (password == null) return false;
    if (password.isEmpty ||
        password.trim().length < 6 ||
        password.trim().length > 50) return false;
    return true;
  }
  static validateEmail(String email){
    if(email == null) return false;
    final regexEmail = RegExp(
      r"^[a-z][a-z0-9_\.]{3,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$"
    );
    return regexEmail.hasMatch(email);
  }

}
