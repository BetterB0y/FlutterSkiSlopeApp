extension FormValidation on String {
  bool get isPasswordValid {
    return length >= 6;
  }

  bool get isUserNameValid {
    return length >= 5 && length <= 20;
  }
}
