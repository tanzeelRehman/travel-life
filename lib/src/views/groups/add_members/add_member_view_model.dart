import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';

class AddMemberViewModel extends ReactiveViewModel {
  init() {}
  List<String> selectedMembersList = [];
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

  void sendInvite() async {
    selectedMembersList.clear();
    notifyListeners();
    Constants.customSuccessSnack('Invitation sent to all users');
    await Future.delayed(Duration(seconds: 2));
    NavService.navigateToGroupHomeScreen(group: Group.dummyGroup);
  }
}
