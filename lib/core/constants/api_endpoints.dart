class ApiEndpoints {
  static const String apiV1 = '/api/v1';

  static const String merchantsAuthBase = '$apiV1/auth/merchants';
  static const String merchantRegister = '$merchantsAuthBase/register';
  static const String merchantLogin = '$merchantsAuthBase/login';
  static const String merchantCurrentUser = merchantsAuthBase;
  static const String merchantLogout = '$merchantsAuthBase/logout';

  const ApiEndpoints._();
}
