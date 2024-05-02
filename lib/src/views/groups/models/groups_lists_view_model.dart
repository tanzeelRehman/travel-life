import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/group_type.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';

class GroupsListsViewModel extends ReactiveViewModel {
  init(GroupType type) {
    if (type == GroupType.public) {
      print('fetch public data');
    } else {
      print('fetch private data');
    }
  }

  navigateToGroupHome(String groupName) {
    NavService.navigateToGroupHomeScreen(groupName: groupName);
  }
}
