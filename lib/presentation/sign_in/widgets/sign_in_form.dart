import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uniplan/application/auth/sign_in_form/sign_in_form_bloc.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          child: ListView(
            children: [
              const Text(
                "📝",
                style: TextStyle(fontSize: 130),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
