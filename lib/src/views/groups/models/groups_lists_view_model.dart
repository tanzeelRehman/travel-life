import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/group_type.dart';

class GroupsListsViewModel extends ReactiveViewModel {
  init(GroupType type) {
    if (type == GroupType.public) {
      print('fetch public data');
    } else {
      print('fetch private data');
    }
  }
}
