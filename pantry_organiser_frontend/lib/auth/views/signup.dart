import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pantry_organiser_frontend/auth/auth.dart';
import 'package:pantry_organiser_frontend/custom_widgets/custom_widgets.dart';
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
          Navigator.of(context).pushReplacementNamed('/home');
        },
        orElse: () {
          showCustomToast(message: 'Failed to sign user up 🚩');
        },
      );
    });

    final authController = ref.watch(authenticationControllerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ReactiveForm(
                  formGroup: form,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const Gap(24),
                      ReactiveTextField<String>(
                        formControlName: 'email',
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      const Gap(16),
                      ReactiveTextField<String>(
                        formControlName: 'password',
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                      ),
                      const Gap(16),
                      ReactiveTextField<String>(
                        formControlName: 'confirmPassword',
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                      ),
                      const Gap(24),
                      ReactiveFormConsumer(
                        builder: (context, formGroup, child) {
                          return AsyncButton(
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
                      const Gap(16),
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                        child: const Text('Have an account? Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
