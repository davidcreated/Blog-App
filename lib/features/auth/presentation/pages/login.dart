import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/features/auth/presentation/pages/signup.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const Signup());

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emaiLController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emaiLController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In.",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),

              AuthField(hintText: "Email", controller: emaiLController),
              const SizedBox(height: 15),
              AuthField(
                hintText: "Password",
                controller: passwordController,
                isObscureText: true,
              ),
              const SizedBox(height: 20),
              AuthGradientButton(
                buttonText: "Sign in",
                onTap: () {
                  // Handle sign in action3
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, Login.route());
                },
                child: RichText(
                  text: TextSpan(
                    text: "Don\t have an account?",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      WidgetSpan(child: SizedBox(width: 10)),
                      TextSpan(
                        text: " Sign Up",
                        style: const TextStyle(
                          color: AppPalette.gradient2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
