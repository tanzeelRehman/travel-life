import 'package:stacked/stacked.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/models/see_all_members_user.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class AllMembersViewModel extends ReactiveViewModel
    with SupabaseAuthViewModel, DatabaseViewModel {
  late final Group group;

  List<SeeAllMembersUser> members = [];

  init(Group g) {
    group = g;
    notifyListeners();

    getSeeAllMembers();
  }

  navigateToMemberProfile(SeeAllMembersUser member, bool isGroupAdmin) {
    NavService.navigateToGroupMembersProfileScreen(
        member: member, isGroupAdmin: isGroupAdmin);
  }

  getSeeAllMembers() async {
    setBusy(true);
    members = await databaseService.getAllMembers(group.id!) ?? [];

    notifyListeners();
    setBusy(false);
  }

  bool isGroupAdmin() {
    return supabaseAuthService.user?.id == group.admin?.id;
  }

  navigateToInviteMiddleScreen() {
    NavService.navigateToInviteMiddleScreen(group: group);
  }
}
