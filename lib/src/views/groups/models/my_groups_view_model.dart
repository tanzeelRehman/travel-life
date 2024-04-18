import 'package:stacked/stacked.dart';

class MyGroupsViewModel extends ReactiveViewModel {
  init() {}
  int selectedTab = 0;
  onChangeTab(int v) {
    selectedTab = v;
    notifyListeners();
  }
}
