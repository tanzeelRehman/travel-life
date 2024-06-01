import 'package:flutter/foundation.dart';

import 'package:starter_app/src/models/app_user.dart';
import 'package:starter_app/src/models/group.dart';

class GroupMember {
  final int? id;
  final DateTime? createdAt;
  final Group? group;
  final DateTime? dateJoined;
  final AppUser? user;
  final bool? joined;
  final bool? invited;
  final bool? requestedToJoin;
  final List<dynamic>? invitedBy;
  final DateTime? joinRequestTime;
  GroupMember({
    this.id,
    this.createdAt,
    this.group,
    this.dateJoined,
    this.user,
    this.joined,
    this.invited,
    this.requestedToJoin,
    required this.invitedBy,
    this.joinRequestTime,
  });

  GroupMember copyWith({
    int? id,
    DateTime? createdAt,
    Group? group,
    DateTime? dateJoined,
    AppUser? user,
    bool? joined,
    bool? invited,
    bool? requestedToJoin,
    List<dynamic>? invitedBy,
    DateTime? joinRequestTime,
  }) {
    return GroupMember(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      group: group ?? this.group,
      dateJoined: dateJoined ?? this.dateJoined,
      user: user ?? this.user,
      joined: joined ?? this.joined,
      invited: invited ?? this.invited,
      requestedToJoin: requestedToJoin ?? this.requestedToJoin,
      invitedBy: invitedBy ?? this.invitedBy,
      joinRequestTime: joinRequestTime ?? this.joinRequestTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'group': group?.toMap(),
      'date_joined': dateJoined?.toIso8601String(),
      'user': user?.toMap(),
      'joined': joined,
      'invited': invited,
      'requested_to_join': requestedToJoin,
      'invited_by': invitedBy,
      'join_request_time': joinRequestTime?.toIso8601String(),
    };
  }

  factory GroupMember.fromMap(Map<String, dynamic> map) {
    return GroupMember(
      id: map['id'] != null ? map['id'] as int : null,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      group: map['group'] != null
          ? Group.fromMap(map['group'] as Map<String, dynamic>)
          : null,
      dateJoined: map['date_joined'] != null
          ? DateTime.parse(map['date_joined'] as String)
          : null,
      user: map['user'] != null
          ? AppUser.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      joined: map['joined'] != null ? map['joined'] as bool : null,
      invited: map['invited'] != null ? map['invited'] as bool : null,
      requestedToJoin: map['requested_to_join'] != null
          ? map['requested_to_join'] as bool
          : null,
      invitedBy: map['invited_by'] != null
          ? List<dynamic>.from((map['invited_by'] as List<dynamic>))
          : null,
      joinRequestTime: map['join_request_time'] != null
          ? DateTime.parse(map['join_request_time'] as String)
          : null,
    );
  }

  @override
  String toString() {
    return 'GroupMember(id: $id, created_at: $createdAt, group: $group, date_joined: $dateJoined, user: $user, joined: $joined, invited: $invited, requested_to_join: $requestedToJoin, invited_by: $invitedBy, joinRequestTime: $joinRequestTime)';
  }

  @override
  bool operator ==(covariant GroupMember other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.group == group &&
        other.dateJoined == dateJoined &&
        other.user == user &&
        other.joined == joined &&
        other.invited == invited &&
        other.requestedToJoin == requestedToJoin &&
        other.joinRequestTime == joinRequestTime &&
        listEquals(other.invitedBy, invitedBy);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        group.hashCode ^
        dateJoined.hashCode ^
        user.hashCode ^
        joined.hashCode ^
        invited.hashCode ^
        requestedToJoin.hashCode ^
        invitedBy.hashCode ^
        joinRequestTime.hashCode;
  }

  static List<GroupMember>? fromJsonList(List<dynamic>? jsonList) {
    return jsonList?.map((e) => GroupMember.fromMap(e)).toList();
  }
}
