class Profile{
  final String userId;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? avatarUrl;

  Profile({
    required this.userId,
    this.firstName,
    this.lastName,
    required this.email,
    this.avatarUrl,
  });

  // Convert Profile to Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'avatarUrl': avatarUrl,
    };
  }

  // Convert Map to Profile
  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      userId: map['userId'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      avatarUrl: map['avatarUrl'],
    );
  }
}