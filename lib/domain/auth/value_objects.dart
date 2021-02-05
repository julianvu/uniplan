import 'package:dartz/dartz.dart';
import 'package:uniplan/domain/core/failures.dart';
import 'package:uniplan/domain/core/value_object.dart';
import 'package:uniplan/domain/core/value_validators.dart';

/// A wrapper for strings representing email addresses.
///
/// This class is more expressive and safe than using solely strings for email
/// addresses since values are validated on creation.
/// Validation during object creation makes illegal states unrepresentable!
class EmailAddress extends ValueObject<String> {
  /// The value of this email address
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    assert(input != null);
    return EmailAddress._(validateEmailAddress(input));
  }

  /// Private constructor for [EmailAddress] that accepts a validated input
  ///
  /// [value] passed to constructor should only be passed to this constructor
  /// if it has already been validated by [validateEmailAddress].
  /// This constructor is privatized for safety.
  const EmailAddress._(this.value);
}
