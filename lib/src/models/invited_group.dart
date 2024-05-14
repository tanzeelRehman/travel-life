import 'package:flutter/foundation.dart';

import 'package:starter_app/src/models/app_user.dart';
import 'package:starter_app/src/models/group.dart';

class InvitedGroup {
  final Group? group;
  final List<AppUser>? invitedBy;
  InvitedGroup({
    this.group,
    this.invitedBy,
  });

  InvitedGroup copyWith({
    Group? group,
    List<AppUser>? invitedBy,
  }) {
    return InvitedGroup(
      group: group ?? this.group,
      invitedBy: invitedBy ?? this.invitedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'group': group?.toMap(),
      'invitedBy': invitedBy?.map((x) => x?.toMap()).toList(),
    };
  }

  factory InvitedGroup.fromMap(Map<String, dynamic> map) {
    return InvitedGroup(
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
  String toString() => 'InvitedGroup(group: $group, invitedBy: $invitedBy)';

  @override
  bool operator ==(covariant InvitedGroup other) {
    if (identical(this, other)) return true;

    return other.group == group && listEquals(other.invitedBy, invitedBy);
  }

  @override
  int get hashCode => group.hashCode ^ invitedBy.hashCode;
}
