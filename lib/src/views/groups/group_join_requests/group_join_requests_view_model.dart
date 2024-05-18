import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/models/group.dart';
import 'package:starter_app/src/models/group_member.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';

class GroupJoinRequestsViewModel extends ReactiveViewModel
    with SupabaseAuthViewModel, DatabaseViewModel {
  late final Group group;

  bool joinRequestLoading = false;

  setJoinRequestLoading(bool v) {
    joinRequestLoading = v;
    notifyListeners();
  }

  List<GroupMember> joinRequests = [];

  init(Group g) {
    group = g;
    notifyListeners();
    getJoinRequests();
  }

  getJoinRequests() async {
    setBusy(true);
    joinRequests = await databaseService.getJoinRequests(group.id!) ?? [];
    notifyListeners();
    setBusy(false);
  }

  acceptJoinRequest(GroupMember member) async {
    setJoinRequestLoading(true);
    final res = await databaseService.approveJoinRequest(member.id!);
    if (res) {
      setJoinRequestLoading(false);
      getJoinRequests();
      Constants.customWarningSnack('Join request rejected');
    }
    setJoinRequestLoading(false);
  }

  rejectJoinRequest(GroupMember member) async {
    setJoinRequestLoading(true);

    final res = await databaseService.rejectJoinRequest(member.id!);
    if (res) {
      setJoinRequestLoading(false);
      Constants.customWarningSnack('Join request rejected');
      getJoinRequests();
    }
    setJoinRequestLoading(false);
  }
}
