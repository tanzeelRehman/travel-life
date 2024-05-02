enum GroupType { public, private }

String getReadableGroupType(GroupType type) {
  switch (type) {
    case GroupType.private:
      return 'Private';
    case GroupType.public:
      return 'Public';

    default:
      throw ArgumentError('Invalid gender: $type');
  }
}
