import "package:blog_app/core/error/faliures.dart";
import "package:fpdart/fpdart.dart";


abstract interface class AuthRepository {
  Future<Either<Failures, String>> signUpwithEmailPasword({
  required String name,
  required String email,
  required String password,
});
Future<Either<Failures, String>> loginwithEmailPasword({
  required String email,
  required String password,
});
} 