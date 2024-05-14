import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/group_action.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';

class MyGroupsViewModel extends ReactiveViewModel {
  init() {}
  int selectedTab = 0;
  onChangeTab(int v) {
    selectedTab = v;
    notifyListeners();
  }

  navigateToGroupEditPage() {
    NavService.navigateToGroupCreateScreen(groupAction: GroupAction.edit);
  }

  navigateToGroupsHome(String groupName) {
    NavService.navigateToGroupHomeScreen(groupName: groupName);
  }
}
