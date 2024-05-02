enum GroupJoin { join, leave, requestJoin }

String getReadableGroupJoinType(GroupJoin type) {
  switch (type) {
    case GroupJoin.join:
      return 'Join';
    case GroupJoin.leave:
      return 'Leave';
    case GroupJoin.requestJoin:
      return 'Request to join';

    default:
      throw ArgumentError('Invalid groupJoin: $type');
  }
}
