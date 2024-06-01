import 'package:flutter/foundation.dart';

import 'package:starter_app/src/models/app_user.dart';
import 'package:starter_app/src/models/group.dart';

class InvitedGroup {
  final int? groupMemberId;
  final Group? group;
  final List<AppUser>? invitedBy;
  final int? groupTotalMembers;
  InvitedGroup({
    this.groupMemberId,
    this.group,
    this.invitedBy,
    this.groupTotalMembers,
  });

  InvitedGroup copyWith({
    int? groupMemberId,
    Group? group,
    List<AppUser>? invitedBy,
    int? groupTotalMembers,
  }) {
    return InvitedGroup(
      groupMemberId: groupMemberId ?? this.groupMemberId,
      group: group ?? this.group,
      invitedBy: invitedBy ?? this.invitedBy,
      groupTotalMembers: groupTotalMembers ?? this.groupTotalMembers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'group': group?.toMap(),
      'invitedBy': invitedBy?.map((x) => x.toMap()).toList(),
      'id': groupMemberId,
    };
  }

  factory InvitedGroup.fromMap(Map<String, dynamic> map) {
    return InvitedGroup(
      groupMemberId: map['id'] != null ? map['id'] as int : null,
      group: map['group'] != null
          ? Group.fromMap(map['group'] as Map<String, dynamic>)
          : null,
      invitedBy: map['invitedBy'] != null
          ? List<AppUser>.from(
              (map['invitedBy'] as List<int>).map<AppUser?>(
                (x) => AppUser.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  static List<InvitedGroup>? fromJsonList(List<dynamic>? jsonList) {
    return jsonList
        ?.map((e) => InvitedGroup.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  @override
  String toString() =>
      'InvitedGroup(group: $group, invitedBy: $invitedBy, id: $groupMemberId)';

  @override
  bool operator ==(covariant InvitedGroup other) {
    if (identical(this, other)) return true;

    return other.groupMemberId == groupMemberId &&
        other.group == group &&
        other.groupTotalMembers == groupTotalMembers &&
        listEquals(other.invitedBy, invitedBy);
  }

  @override
  int get hashCode =>
      groupMemberId.hashCode ^
      group.hashCode ^
      invitedBy.hashCode ^
      groupTotalMembers.hashCode;
}
