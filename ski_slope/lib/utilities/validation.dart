extension FormValidation on String {
  bool get isPasswordValid {
    return length >= 5 && length <= 20;
  }

  bool get isUserNameValid {
    return length >= 5 && length <= 20;
  }
}
