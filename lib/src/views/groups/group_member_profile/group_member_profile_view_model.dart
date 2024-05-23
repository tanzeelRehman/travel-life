import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/models/see_all_members_user.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';

class GroupMemberProfileViewModel extends ReactiveViewModel
    with DatabaseViewModel {
  late final SeeAllMembersUser user;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateOfJoinController = TextEditingController();

  init(SeeAllMembersUser member) {
    user = member;

    notifyListeners();

    nameController.text = user.user?.firstname ?? '';
    emailController.text = user.user?.email ?? '';
    dateOfJoinController.text = user.dateJoined != null
        ? DateFormat('yMMMd').format(user.dateJoined!)
        : '----';

    notifyListeners();
  }

  onRemoveGroupMember() async {
    setBusy(true);

    final res = await databaseService
        .leaveOrRemoveUserFromGroupByGroudMemberId(user.groupMemberId!);

    if (res) {
      setBusy(false);
      NavService.back();
      NavService.back(); //might not be the best approach but eh
      Constants.customSuccessSnack(
          'Removed ${user.user?.firstname ?? '----'} from group');
      return;
    }

    setBusy(false);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    dateOfJoinController.dispose();
    super.dispose();
  }
}
