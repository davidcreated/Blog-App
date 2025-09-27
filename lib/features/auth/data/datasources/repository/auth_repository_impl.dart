import 'package:blog_app/core/error/faliures.dart';
import 'package:blog_app/core/exceptions.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failures, String>> signUpwithEmailPasword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      print('🔵 Repository: Calling remote data source for signup');
      final userId = await authRemoteDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      print('🟢 Repository: Signup successful - UID: $userId');
      return right(userId);
    } on ServerException catch (e) {
      print('🔴 Repository: Server exception - ${e.message}');
      return left(Failures(e.message));
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      return left(Failures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> loginwithEmailPasword({
    required String email,
    required String password,
  }) async {
    try {
      final userId = await authRemoteDataSource.loginInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(userId);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    } catch (e) {
      return left(Failures(e.toString()));
    }
  }
}
