import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/group_action.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/ors_service_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class EventsMainViewModel extends ReactiveViewModel
    with
        DatabaseViewModel,
        SupabaseAuthViewModel,
        DataViewModel,
        OrsServiceViewModel {
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

  searchAutocomplete(String searchQuery) async {
    setBusy(true);
    final res = await orsService.searchAutocomplete(searchQuery);
    if (res == null) {
      setBusy(false);
      return;
    }
    res.when(
      success: (data) {
        print('success data: $data');
        setBusy(false);
      },
      failure: (error) {
        print('error: $error');
        setBusy(false);
      },
    );
  }
}
