part of 'sign_in_form_bloc.dart';

/// Defines the states that the SignInForm can be in
@freezed
abstract class SignInFormState with _$SignInFormState {
  /// The factory for creating a state
  ///
  /// @param  emailAddress                The EmailAddress being passed into this form
  /// @param  password                    The Password being passed into this form
  /// @param  showErrorMessages           Whether this form should show error messages
  /// @param  isSubmitting                Whether this form is being submitted
  /// @param  authFailureOrSuccessOption  The Option containing an Either for whether the authentication attempt failed or not. `none()` means no sign-in attempt has been made. `some()` means a sign-in attempt has been made.
  const factory SignInFormState({
    @required EmailAddress emailAddress,
    @required Password password,
    @required AutovalidateMode showErrorMessages,
    @required bool isSubmitting,
    @required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
  }) = _SignInFormState;

  factory SignInFormState.initial() => SignInFormState(
        emailAddress: EmailAddress(""),
        password: Password(""),
        showErrorMessages: AutovalidateMode.disabled,
        isSubmitting: false,
        authFailureOrSuccessOption: none(),
      );
}
