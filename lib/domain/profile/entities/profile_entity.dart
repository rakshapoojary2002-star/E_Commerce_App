class ProfileEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;

  const ProfileEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
  });
}
