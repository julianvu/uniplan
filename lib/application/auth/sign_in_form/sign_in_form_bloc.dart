import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:uniplan/domain/auth/auth_failure.dart';
import 'package:uniplan/domain/auth/i_auth_facade.dart';
import 'package:uniplan/domain/auth/value_objects.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

/// Translates incoming SignInFormEvents into a SignInFormState
@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade; // Used for calling auth-related logic

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial());

  @override
  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    yield* event.map(
      emailChanged: (e) async* {
        yield state.copyWith(
          emailAddress: EmailAddress(e.emailStr),
          authFailureOrSuccessOption: none(),
        );
      },
      passwordChanged: (e) async* {
        yield state.copyWith(
          password: Password(e.passwordStr),
          authFailureOrSuccessOption: none(),
        );
      },
      registerWithEmailAndPasswordPressed: (e) async* {
        yield* _performAuthAction(_authFacade.registerWithEmailAndPassword);
      },
      signInWithEmailAndPasswordPressed: (e) async* {
        yield* _performAuthAction(_authFacade.signInWithEmailAndPassword);
      },
      signInWithGoogle: (e) async* {
        yield state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        );
        final failureOrSuccess = await _authFacade.signInWithGoogle();
        yield state.copyWith(
          isSubmitting: false,
          authFailureOrSuccessOption: some(failureOrSuccess),
        );
      },
    );
  }

  /// Performs an authentication action on the auth facade with email and password.
  ///
  /// @param    authFunctionCallback  the callback function to be called for an authentication action (either register or sign-in)
  /// @returns  A Stream of SignInFormState
  Stream<SignInFormState> _performAuthAction(
    Future<Either<AuthFailure, Unit>> Function({
      @required EmailAddress emailAddress,
      @required Password password,
    })
        authFunctionCallback,
  ) async* {
    Either<AuthFailure, Unit> failureOrSuccess;
    final bool isEmailValid = state.emailAddress.isValid();
    final bool isPasswordValid = state.password.isValid();
    if (isEmailValid && isPasswordValid) {
      // Emit the submitting state
      yield state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      );

      // Make an authentication attempt with the given email and password and
      // store the result in the failureOrSuccess Either<>
      failureOrSuccess = await authFunctionCallback(
        emailAddress: state.emailAddress,
        password: state.password,
      );
    }

    // Emit a new state after the authentication attempt is made
    yield state.copyWith(
      isSubmitting: false,
      showErrorMessages: AutovalidateMode.always,
      // optionOf() returns none() if no authentication attempt was made, and
      // some() otherwise
      authFailureOrSuccessOption: optionOf(failureOrSuccess),
    );
  }
}
