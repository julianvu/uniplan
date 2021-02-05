import 'package:dartz/dartz.dart';
import 'package:uniplan/domain/core/failures.dart';

/// Validates [input] to ensure it is properly formatted as an email address
/// with a regex.
Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  // The following regex string is the HTML5 email validation spec
  const String emailRegex =
      r"""^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$""";
  if (RegExp(emailRegex).hasMatch(input)) {
    // right side of Either is valid
    return right(input);
  } else {
    // left side of Either is invalid
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

/// Validates [input] to ensure it is greather than 6 characters
Either<ValueFailure<String>, String> validatePassword(String input) {
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(ValueFailure.shortPassword(failedValue: input));
  }
}
