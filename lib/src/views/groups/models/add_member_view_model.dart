import 'package:stacked/stacked.dart';

class AddMemberViewModel extends ReactiveViewModel {
  init() {}
  List<String> selectedMembersList = ['Tanzeel'];
  List<String> allMembersList = [
    'Tanzeel',
    'Ahmed',
    'Kami',
    'Muazzam',
    'Alice',
    'Bob',
    'Charlie',
    'David',
    'Emma',
    'Frank',
    'Grace',
    'Henry',
    'Ivy',
    'Jack',
    'Kelly',
    'Liam',
    'Mia',
    'Noah',
    'Olivia',
    'Peter',
    'Quinn',
    'Rachel',
    'Sam',
    'Taylor',
    'Uma',
    'Victor',
    'Wendy',
    'Xavier',
    'Yvonne',
    'Zack'
  ];

  bool membersIsInList(String member) {
    if (selectedMembersList.contains(member)) {
      print(selectedMembersList.contains(member));
      return true;
    } else {
      print(false);
      return false;
    }
  }

  void addMemberToList(String member) {
    selectedMembersList.add(member);
    notifyListeners();
  }

  void removeMemberToList(String member) {
    selectedMembersList.remove(member);
    notifyListeners();
  }
}
