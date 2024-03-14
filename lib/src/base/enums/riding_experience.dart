enum RidingExperience {
  beginner,
  intermediate,
  experienced,
}

String getReadableRidingExperience(RidingExperience experience) {
  switch (experience) {
    case RidingExperience.beginner:
      return 'Beginner';
    case RidingExperience.intermediate:
      return 'Intermediate';
    case RidingExperience.experienced:
      return 'Experienced';
    default:
      throw ArgumentError('Invalid riding experience: $experience');
  }
}

RidingExperience getRidingExperienceFromReadable(String text) {
  switch (text.toLowerCase()) {
    case 'beginner':
      return RidingExperience.beginner;
    case 'intermediate':
      return RidingExperience.intermediate;
    case 'experienced':
      return RidingExperience.experienced;
    default:
      throw ArgumentError('Invalid riding experience text: $text');
  }
}
