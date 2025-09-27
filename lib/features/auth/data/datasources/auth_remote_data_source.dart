import 'package:blog_app/core/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> loginInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<String> loginInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      print('🔵 Data Source: Attempting login for $email');
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw ServerException("Login failed - User is null");
      }

      print('🟢 Data Source: Login successful - UID: ${response.user!.id}');
      return response.user!.id;
    } on AuthException catch (e) {
      print('🔴 Data Source: Auth exception - ${e.message}');
      throw ServerException('Auth Error: ${e.message}');
    } catch (e) {
      print('🔴 Data Source: Unexpected error - $e');
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      print('🔵 Data Source: Attempting signup for $email');
      print('🔵 Data Source: Password length: ${password.length}');
      print('🔵 Data Source: Name: $name');

      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: null,
        data: {'name': name},
      );

      print('🔵 Data Source: Response received');
      print('🔵 Data Source: User is null? ${response.user == null}');

      if (response.user == null) {
        print('🔴 Data Source: User is null after signup');
        throw ServerException(
          "User is null - Email might already exist or email confirmation required",
        );
      }

      final user = response.user!;
      print('🟢 Data Source: Signup successful');
      print('🟢 Data Source: UID: ${user.id}');
      print('🟢 Data Source: Email: ${user.email}');
      print('🟢 Data Source: Is Anonymous: ${user.isAnonymous}');

      return user.id;
    } on AuthException catch (e) {
      print('🔴 Data Source: Auth exception - ${e.message}');
      print('🔴 Data Source: Status code: ${e.statusCode}');
      throw ServerException('Auth Error: ${e.message}');
    } catch (e) {
      print('🔴 Data Source: Unexpected error - $e');
      throw ServerException(e.toString());
    }
  }
}
