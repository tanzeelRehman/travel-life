import 'package:stacked/stacked.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';

class InviteMiddleScreenViewModel extends ReactiveViewModel {
  late final Group group;

  init(Group g) {
    group = g;
    notifyListeners();
  }

  navigateToAddMembersScrren() {
    NavService.navigateToAddMemberScreen(group: group);
  }
}
