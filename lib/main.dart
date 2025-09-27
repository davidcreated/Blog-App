import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';

import 'package:blog_app/features/auth/data/datasources/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';

import 'package:blog_app/features/auth/presentation/pages/signup.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            userSignUp: UserSignUp(
              authRepository: AuthRepositoryImpl(
                authRemoteDataSource: AuthRemoteDataSourceImpl(
                  supabaseClient: supabase.client,
                ),
              ),
            ),
          ),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Blog App",
      theme: AppTheme.darkThemeMode,
      debugShowCheckedModeBanner: false,
      home: Signup(),
    );
  }
}
