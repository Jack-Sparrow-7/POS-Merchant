import 'package:pos_merchant/domain/Entities/user.dart';
import 'package:pos_merchant/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repo;

  RegisterUsecase({required this.repo});

  Future<User> call({
    required String name,
    required String businessName,
    required String mobileNumber,
    required String email,
    required String password,
  }) {
    return repo.register(
      name: name,
      businessName: businessName,
      mobileNumber: mobileNumber,
      email: email,
      password: password,
    );
  }
}
