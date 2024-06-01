enum GroupJoin { join, leave, requestJoin, accept }

String getReadableGroupJoinType(GroupJoin type) {
  switch (type) {
    case GroupJoin.join:
      return 'Join';
    case GroupJoin.leave:
      return 'Leave';
    case GroupJoin.requestJoin:
      return 'Request to join';
    case GroupJoin.accept:
      return 'Accept';

    default:
      throw ArgumentError('Invalid groupJoin: $type');
  }
}
