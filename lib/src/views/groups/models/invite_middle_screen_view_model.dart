import 'package:stacked/stacked.dart';
import 'package:starter_app/src/services/local/navigation_service.dart';

class InviteMiddleScreenViewModel extends ReactiveViewModel {
  init() {}

  navigateToAddMembersScrren() {
    NavService.navigateToAddMemberScreen();
  }
}
