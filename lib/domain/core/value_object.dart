import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:uniplan/domain/core/errors.dart';
import 'package:uniplan/domain/core/failures.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  /// The value of this ValueObject.
  Either<ValueFailure<T>, T> get value;

  /// Gets the actual value of this ValueObject if valid, otherwise crashes.
  /// This method folds the value. If a left value exists, there is an error
  /// and the method throws [UnexpectedValueError] containing the [ValueFailure].
  T getOrCrash() {
    // id = identity = same is (r) => r
    return value.fold((l) => throw UnexpectedValueError(), id);
  }

  /// Genericizes the value type if there is a ValueFailure or unit
  /// (the equivalent of null) if the value is valid.
  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold(
      (l) => left(l),
      (r) => right(unit),
    );
  }

  /// Returns `true` if the value is valid
  bool isValid() => value.isRight();

  /// Returns `true` if the values compared are equal or identical.
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ValueObject<T> && o.value == o.value;
  }

  /// The hashcode of this ValueObject
  @override
  int get hashCode => value.hashCode;

  /// Returns the string representation of this ValueObject.
  @override
  String toString() => "Value(value: $value)";
}
