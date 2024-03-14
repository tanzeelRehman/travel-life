enum BloodGroup {
  o_positive,
  o_negative,
  a_positive,
  a_negative,
  b_positive,
  b_negative,
  ab_positive,
  ab_negative
}

String getReadableBloodGroup(BloodGroup bloodGroup) {
  switch (bloodGroup) {
    case BloodGroup.o_positive:
      return 'O+';
    case BloodGroup.o_negative:
      return 'O-';
    case BloodGroup.a_positive:
      return 'A+';
    case BloodGroup.a_negative:
      return 'A-';
    case BloodGroup.b_positive:
      return 'B+';
    case BloodGroup.b_negative:
      return 'B-';
    case BloodGroup.ab_positive:
      return 'AB+';
    case BloodGroup.ab_negative:
      return 'AB-';
    default:
      throw ArgumentError('Invalid blood group: $bloodGroup');
  }
}

BloodGroup getBloodGroupFromReadable(String text) {
  switch (text) {
    case 'O+':
      return BloodGroup.o_positive;
    case 'O-':
      return BloodGroup.o_negative;
    case 'A+':
      return BloodGroup.a_positive;
    case 'A-':
      return BloodGroup.a_negative;
    case 'B+':
      return BloodGroup.b_positive;
    case 'B-':
      return BloodGroup.b_negative;
    case 'AB+':
      return BloodGroup.ab_positive;
    case 'AB-':
      return BloodGroup.ab_negative;
    default:
      throw ArgumentError('Invalid blood group text: $text');
  }
}
