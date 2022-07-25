class ValidatePassword {
  bool execute(String password) {
    if (password.length < 6) return false;

    if (password.startsWith(RegExp("0..9"))) return false;

    if (password.contains(' ')) return false;

    return true;
  }
}
