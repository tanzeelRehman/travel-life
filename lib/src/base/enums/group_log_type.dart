enum GroupLogType {
  group_create,
  group_edit,
  group_join,
  invite,
  invite_accept,
  invite_reject,
  request_join,
  request_join_accept,
  request_join_reject,
}

String getReadableGroupLogType(GroupLogType type) {
  switch (type) {
    case GroupLogType.group_create:
      return 'Group Create';
    case GroupLogType.group_edit:
      return 'Group Edit';
    case GroupLogType.group_join:
      return 'Group Join';
    case GroupLogType.invite:
      return 'Invite';
    case GroupLogType.invite_accept:
      return 'Invite Accept';
    case GroupLogType.invite_reject:
      return 'Invite Reject';
    case GroupLogType.request_join:
      return 'Request Join';
    case GroupLogType.request_join_accept:
      return 'Request Join Accept';
    case GroupLogType.request_join_reject:
      return 'Request Join Reject';
    default:
      throw ArgumentError('Invalid GroupLogType: $type');
  }
}

GroupLogType getGroupLogTypeFromReadable(String text) {
  switch (text.toLowerCase()) {
    case 'group create':
      return GroupLogType.group_create;
    case 'group edit':
      return GroupLogType.group_edit;
    case 'group join':
      return GroupLogType.group_join;
    case 'invite':
      return GroupLogType.invite;
    case 'invite accept':
      return GroupLogType.invite_accept;
    case 'invite reject':
      return GroupLogType.invite_reject;
    case 'request join':
      return GroupLogType.request_join;
    case 'request join accept':
      return GroupLogType.request_join_accept;
    case 'request join reject':
      return GroupLogType.request_join_reject;
    default:
      throw ArgumentError('Invalid GroupLogType text: $text');
  }
}
