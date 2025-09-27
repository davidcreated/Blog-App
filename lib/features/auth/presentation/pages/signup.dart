import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signup extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const Login());

  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final emaiLController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emaiLController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            print('🔴 Signup Error: ${state.errorMessage}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 5),
              ),
            );
          } else if (state is AuthSuccess) {
            print('🟢 Signup Success: ${state.userId}');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account created successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        "Sign Up.",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 25),
                      AuthField(hintText: "Name", controller: nameController),
                      const SizedBox(height: 15),
                      AuthField(hintText: "Email", controller: emaiLController),
                      const SizedBox(height: 15),
                      AuthField(
                        hintText: "Password",
                        controller: passwordController,
                        isObscureText: true,
                      ),
                      const SizedBox(height: 30),
                      AuthGradientButton(
                        buttonText: "Sign up",
                        onTap: () {
                          print('📝 Button tapped');
                          print('📝 Name: "${nameController.text}"');
                          print('📝 Email: "${emaiLController.text}"');
                          print('📝 Password: "${passwordController.text}"');

                          if (formKey.currentState!.validate()) {
                            print('✅ Form validated');

                            final name = nameController.text.trim();
                            final email = emaiLController.text.trim();
                            final password = passwordController.text.trim();

                            if (name.isEmpty ||
                                email.isEmpty ||
                                password.isEmpty) {
                              print('❌ Empty fields detected!');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please fill all fields'),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                              return;
                            }

                            context.read<AuthBloc>().add(
                              AuthSignUp(
                                name: name,
                                email: email,
                                password: password,
                              ),
                            );
                          } else {
                            print('❌ Form validation failed');
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, Signup.route());
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account?",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: const [
                              WidgetSpan(child: SizedBox(width: 10)),
                              TextSpan(
                                text: " Sign In",
                                style: TextStyle(
                                  color: AppPalette.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
