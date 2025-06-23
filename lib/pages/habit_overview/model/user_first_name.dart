class AppUser {
  final String uid;
  final String firstName;

  AppUser({required this.uid, required this.firstName});

  factory AppUser.fromMap(Map<String, dynamic> map, String uid) {
    return AppUser(
      uid: uid,
      firstName: map['firstName'] ?? '',
    );
  }
}
