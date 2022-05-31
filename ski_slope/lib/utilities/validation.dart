extension FormValidation on String {
  bool get isFirstNameValid {
    return length > 0;
  }

  bool get isLastNameValid {
    return length > 0;
  }

  bool get isUserNameValid {
    return length >= 5 && length <= 20;
  }

  bool get isEmail {
    final regExp = RegExp(
        "(?:[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*|\"*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:+)])");
    final allMatches = regExp.allMatches(toLowerCase());
    // reason for not using regExp.hasMatch(this) is that it could find match
    // which matches only part of [this], e.g. correct@mail@it.com, will match
    // only mail@it.com not the entire string, which resulted in errors
    return allMatches.length == 1 && allMatches.first.start == 0 && allMatches.first.end == length;
  }

  bool get isPasswordValid {
    return length >= 5 && length <= 20;
  }
}
