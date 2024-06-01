import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/group_type.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';

class GroupsListsViewModel extends ReactiveViewModel
    with DatabaseViewModel, DataViewModel {
  init(GroupType type) async {
    if (type == GroupType.public) {
      await loadPublicGroups();
    } else {
      await loadPrivateGroups();
    }
  }

  loadPublicGroups() async {
    setBusy(true);
    dataService.publicGroups = await databaseService.getPublicGroups() ?? [];
    notifyListeners();
    setBusy(false);
  }

  loadPrivateGroups() async {
    setBusy(true);
    dataService.privateGroups = await databaseService.getPrivateGroups() ?? [];
    notifyListeners();
    setBusy(false);
  }
}
