enum Gender { male, female, others }

String getReadableGender(Gender gender) {
  switch (gender) {
    case Gender.male:
      return 'Male';
    case Gender.female:
      return 'Female';
    case Gender.others:
      return 'Others';
    default:
      throw ArgumentError('Invalid gender: $gender');
  }
}

Gender getGenderFromReadable(String text) {
  switch (text.toLowerCase()) {
    case 'male':
      return Gender.male;
    case 'female':
      return Gender.female;
    case 'others':
      return Gender.others;
    default:
      throw ArgumentError('Invalid gender text: $text');
  }
}
