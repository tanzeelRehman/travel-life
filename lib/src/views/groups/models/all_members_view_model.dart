import 'package:stacked/stacked.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';

class AllMembersViewModel extends ReactiveViewModel {
  init() {}

  navigateToMemberProfile() {
    NavService.navigateToGroupMembersProfileScreen();
  }

  navigateToInviteMiddleScreen() {
    NavService.navigateToInviteMiddleScreen();
  }
}
