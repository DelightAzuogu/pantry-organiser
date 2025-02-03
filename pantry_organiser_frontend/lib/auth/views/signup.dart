import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pantry_organiser_frontend/auth/auth.dart';
import 'package:pantry_organiser_frontend/helpers/showCustomToast.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpPage extends ConsumerWidget {
  SignUpPage({super.key});

  final FormGroup form = FormGroup(
    {
      'email': FormControl<String>(
        validators: [
          Validators.required,
          Validators.email,
        ],
      ),
      'password': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(6),
        ],
      ),
      'confirmPassword': FormControl<String>(
        validators: [Validators.required],
      ),
    },
    validators: [
      Validators.mustMatch('password', 'confirmPassword'),
    ],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authenticationControllerProvider, (_, next) {
      next.maybeWhen(
        authenticated: (_) {
          Navigator.of(context).pushReplacementNamed(
            '/home',
          );
        },
        orElse: () {
          showCustomToast(message: 'Failed to sign user up 🚩');
        },
      );
    });

    final authController = ref.watch(authenticationControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: [
              ReactiveTextField<String>(
                formControlName: 'email',
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validationMessages: {
                  ValidationMessage.required: (error) => 'Email is required',
                  ValidationMessage.email: (error) => 'Enter a valid email',
                },
              ),
              const Gap(16),
              ReactiveTextField<String>(
                formControlName: 'password',
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validationMessages: {
                  ValidationMessage.required: (error) => 'Password is required',
                  ValidationMessage.minLength: (error) => 'Password must be at least 6 characters long',
                },
              ),
              const Gap(16),
              ReactiveTextField<String>(
                formControlName: 'confirmPassword',
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                validationMessages: {
                  ValidationMessage.required: (error) => 'Confirm Password is required',
                  'mustMatch': (error) => 'Passwords do not match',
                },
              ),
              const Gap(32),
              ReactiveFormConsumer(
                builder: (context, formGroup, child) {
                  return ElevatedButton(
                    onPressed: form.valid
                        ? () async {
                            await authController.register(
                              form.control('email').value as String,
                              form.control('password').value as String,
                            );
                          }
                        : null,
                    child: const Text('Sign Up'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
