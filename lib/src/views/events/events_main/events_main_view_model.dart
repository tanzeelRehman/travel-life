import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/group_action.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class EventsMainViewModel extends ReactiveViewModel
    with DatabaseViewModel, SupabaseAuthViewModel, DataViewModel {
  init() async {
    await getAllEvents();
  }

  navigateToAddEvent() {
    NavService.navigateToEventCreateScreen(
      groupAction: GroupAction.add,
      group: null,
    );
  }

  getAllEvents() async {
    setBusy(true);
    dataService.allEvents = await databaseService.getAllEvents() ?? [];
    notifyListeners();
    setBusy(false);
  }
}
