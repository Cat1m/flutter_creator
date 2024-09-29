extension EmailValidatoreExtension on String {
  bool emailValidator() {
    bool emailValid =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
            .hasMatch(this);
    return emailValid;
  }
}
