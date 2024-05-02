import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/group_action.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';

class GroupHomeViewModel extends ReactiveViewModel {
  init() {}

  navigateToSeeAllMembers() {
    NavService.navigateToAllMemberScreen();
  }

  navigateToEditGroupDetails() {
    NavService.navigateToGroupCreateScreen(groupAction: GroupAction.edit);
  }

  navigateToJoinRequestsScreen() {
    NavService.navigateToGroupJoinRequestsScreen();
  }
}
