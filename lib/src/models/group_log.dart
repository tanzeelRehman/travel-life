import 'package:starter_app/src/base/enums/group_log_type.dart';
import 'package:starter_app/src/models/app_user.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/services/remote/supabase_auth_service.dart';

class GroupLog {
  final int? id;
  final DateTime? createdAt;
  final Group? group;
  final AppUser? user;
  final String? message;
  final GroupLogType? type;
  GroupLog({
    this.id,
    this.createdAt,
    this.group,
    this.user,
    this.message,
    this.type,
  });

  GroupLog copyWith({
    int? id,
    DateTime? createdAt,
    Group? group,
    AppUser? user,
    String? message,
    GroupLogType? type,
  }) {
    return GroupLog(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      group: group ?? this.group,
      user: user ?? this.user,
      message: message ?? this.message,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    print('group: ${group?.id}');
    print('user: ${user?.id}');
    print('type: ${type}');
    return <String, dynamic>{
      // 'id': id,
      // 'created_at': createdAt?.toIso8601String(),
      'group': group?.id,
      'user': user?.id,
      // 'message': message,
      'type': type != null ? getReadableGroupLogType(type!) : null,
    };
  }

  factory GroupLog.fromMap(Map<String, dynamic> map) {
    return GroupLog(
      id: map['id'] != null ? map['id'] as int : null,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      group: map['group'] != null
          ? Group.fromMap(map['group'] as Map<String, dynamic>)
          : null,
      user: map['user'] != null
          ? AppUser.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      message: map['message'] != null ? map['message'] as String : null,
      type:
          map['type'] != null ? getGroupLogTypeFromReadable(map['type']) : null,
    );
  }

  @override
  String toString() {
    return 'GroupMember(id: $id, created_at: $createdAt, group: $group, user: $user, message: $message, type: $type)';
  }

  @override
  bool operator ==(covariant GroupLog other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.group == group &&
        other.message == message &&
        other.type == type &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        group.hashCode ^
        message.hashCode ^
        type.hashCode ^
        user.hashCode;
  }

  static List<GroupLog>? fromJsonList(List<dynamic>? jsonList) {
    return jsonList?.map((e) => GroupLog.fromMap(e)).toList();
  }

  static String getLogMessage(GroupLog log) =>
      generateLogMessage(log, SupabaseAuthService().user!);
}

String generateLogMessage(GroupLog log, AppUser currentUser) {
  String username = log.user?.firstname ?? 'Someone';
  String groupName = log.group?.name ?? 'the group';

  switch (log.type) {
    case GroupLogType.group_create:
      return (log.user?.id == currentUser.id)
          ? 'You created $groupName.'
          : '$username created $groupName.';
    case GroupLogType.group_edit:
      return (log.user?.id == currentUser.id)
          ? 'You edited $groupName.'
          : '$username edited $groupName.';
    case GroupLogType.group_join:
      return (log.user?.id == currentUser.id)
          ? 'You joined $groupName.'
          : '$username joined $groupName.';
    case GroupLogType.invite:
      return (log.user?.id == currentUser.id)
          ? 'You have been invited to $groupName.'
          : '$username was invited to $groupName.';
    case GroupLogType.invite_accept:
      return (log.user?.id == currentUser.id)
          ? 'You accepted an invitation to join $groupName.'
          : '$username accepted an invitation to join $groupName.';
    case GroupLogType.invite_reject:
      return (log.user?.id == currentUser.id)
          ? 'You rejected an invitation to join $groupName.'
          : '$username rejected an invitation to join $groupName.';
    case GroupLogType.request_join:
      return (log.user?.id == currentUser.id)
          ? 'You requested to join $groupName.'
          : '$username requested to join $groupName.';
    case GroupLogType.request_join_accept:
      return (log.user?.id == currentUser.id)
          ? 'Your request to join $groupName was accepted.'
          : '$username\'s request to join $groupName was accepted.';
    case GroupLogType.request_join_reject:
      return (log.user?.id == currentUser.id)
          ? 'Your request to join $groupName was rejected.'
          : '$username\'s request to join $groupName was rejected.';
    default:
      return 'Unknown log type';
  }
}
