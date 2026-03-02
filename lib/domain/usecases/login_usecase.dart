import 'package:pos_merchant/domain/Entities/user.dart';
import 'package:pos_merchant/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repo;

  LoginUsecase({required this.repo});

  Future<User> call({required String email, required String password}) {
    return repo.login(email: email, password: password);
  }
}
