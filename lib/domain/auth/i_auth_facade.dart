import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:uniplan/domain/auth/auth_failure.dart';
import 'package:uniplan/domain/auth/value_objects.dart';

/// An interface for authentication protocols employing the facade design pattern.
/// This interface removes dependencies on different authentication protocols.
/// Facades connect multiple interfaces together
abstract class IAuthFacade {
  /// Register a new user with an email and password
  /// Returns a Future of an Either. [Unit] is the object-equivalent of `void`
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {@required EmailAddress emailAddress, @required Password password});

  /// Sign in with an email and password
  /// Returns a Future of an Either. [Unit] is the object-equivalent of `void`
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {@required EmailAddress emailAddress, @required Password password});

  /// Sign in with Google. This method automatically handles sign-up
  /// Returns a Future of an Either. [Unit] is the object-equivalent of `void`
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}
