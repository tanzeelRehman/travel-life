import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/group_action.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class GroupHomeViewModel extends ReactiveViewModel with SupabaseAuthViewModel {
  late final Group group;
  init(Group g) {
    group = g;
    notifyListeners();
  }

  navigateToSeeAllMembers() {
    NavService.navigateToAllMemberScreen(group: group);
  }

  navigateToEditGroupDetails() {
    NavService.navigateToGroupCreateScreen(
      groupAction: GroupAction.edit,
      group: group,
    );
  }

  bool isGroupAdmin() {
    return supabaseAuthService.user?.id == group.admin?.id;
  }

  navigateToJoinRequestsScreen() {
    NavService.navigateToGroupJoinRequestsScreen(group: group);
  }
}
