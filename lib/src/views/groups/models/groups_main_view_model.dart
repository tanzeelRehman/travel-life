import 'package:stacked/stacked.dart';

class GroupsMainViewModel extends ReactiveViewModel {
  init() {}
  initGroupsList(String groupType) {
    if (groupType == 'Public') {
      print('fetch pub;ic groups');
    } else {
      print('fetch private groups');
    }
  }
}
