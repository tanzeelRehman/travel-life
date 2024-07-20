import 'package:stacked/stacked.dart';
import 'package:starter_app/src/models/group_log.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';

class GroupActivitiesViewModel extends ReactiveViewModel
    with DatabaseViewModel, DataViewModel {
  init() async {
    getLogs();
  }

  List<GroupLog> logs = [];

  getLogs() async {
    setBusy(true);
    logs = await databaseService.getGroupLogs() ?? [];
    logs.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    notifyListeners();
    setBusy(false);
  }
}
