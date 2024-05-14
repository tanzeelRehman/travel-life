import 'package:starter_app/src/models/app_user.dart';

class SeeAllMembersUser {
  final AppUser? user;
  final DateTime? dateJoined;
  SeeAllMembersUser({
    this.user,
    this.dateJoined,
  });

  SeeAllMembersUser copyWith({
    AppUser? user,
    DateTime? dateJoined,
  }) {
    return SeeAllMembersUser(
      user: user ?? this.user,
      dateJoined: dateJoined ?? this.dateJoined,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
      'date_joined': dateJoined?.toIso8601String(),
    };
  }

  factory SeeAllMembersUser.fromMap(Map<String, dynamic> map) {
    return SeeAllMembersUser(
      user: map['user'] != null
          ? AppUser.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      dateJoined: map['date_joined'] != null
          ? DateTime.parse(map['date_joined'] as String)
          : null,
    );
  }

  @override
  String toString() =>
      'SeeAllMembersUser(user: $user, joinRequestTime: $dateJoined)';

  @override
  bool operator ==(covariant SeeAllMembersUser other) {
    if (identical(this, other)) return true;

    return other.user == user && other.dateJoined == dateJoined;
  }

  @override
  int get hashCode => user.hashCode ^ dateJoined.hashCode;

  static List<SeeAllMembersUser>? fromJsonList(List<dynamic>? jsonList) {
    return jsonList?.map((e) => SeeAllMembersUser.fromMap(e)).toList();
  }
}
