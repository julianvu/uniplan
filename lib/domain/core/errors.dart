import 'package:uniplan/domain/core/failures.dart';

class NotAuthenticatedError extends Error {}

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() => Error.safeToString(
      'Encounted a ValueFailure at an unrecoverable point. Terminating...\nUnexpectedValueError(valueFailure: $valueFailure)');
}
