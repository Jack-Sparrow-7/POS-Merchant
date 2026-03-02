class User {
  final String id;
  final String name;
  final String businessName;
  final String mobileNumber;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.businessName,
    required this.mobileNumber,
    required this.createdAt,
    required this.updatedAt,
  });
}
