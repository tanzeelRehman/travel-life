import 'package:starter_app/src/models/app_user.dart';

class SeeAllMembersUser {
  final int? groupMemberId;
  final AppUser? user;
  final DateTime? dateJoined;
  SeeAllMembersUser({
    this.groupMemberId,
    this.user,
    this.dateJoined,
  });

  SeeAllMembersUser copyWith({
    int? groupMemberId,
    AppUser? user,
    DateTime? dateJoined,
  }) {
    return SeeAllMembersUser(
      groupMemberId: groupMemberId ?? this.groupMemberId,
      user: user ?? this.user,
      dateJoined: dateJoined ?? this.dateJoined,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
      'date_joined': dateJoined?.toIso8601String(),
      'id': groupMemberId,
    };
  }

  factory SeeAllMembersUser.fromMap(Map<String, dynamic> map) {
    return SeeAllMembersUser(
      groupMemberId: map['id'] != null ? map['id'] as int : null,
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
      'SeeAllMembersUser(user: $user, joinRequestTime: $dateJoined, id: $groupMemberId)';

  @override
  bool operator ==(covariant SeeAllMembersUser other) {
    if (identical(this, other)) return true;

    return other.user == user &&
        other.groupMemberId == groupMemberId &&
        other.dateJoined == dateJoined;
  }

  @override
  int get hashCode =>
      user.hashCode ^ dateJoined.hashCode ^ groupMemberId.hashCode;

  static List<SeeAllMembersUser>? fromJsonList(List<dynamic>? jsonList) {
    return jsonList?.map((e) => SeeAllMembersUser.fromMap(e)).toList();
  }
}
