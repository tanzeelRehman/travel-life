import 'package:stacked/stacked.dart';
import 'package:starter_app/src/models/accessory_category.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';

class AccessoryCategoryDialogViewModel extends ReactiveViewModel
    with DataViewModel {
  AccessoryCategory? selectedAccessoryCategory;

  onChangeAccessoryCategory(AccessoryCategory? v) {
    if (v != null) {
      selectedAccessoryCategory = v;
      notifyListeners();
    }
  }

  List<AccessoryCategory> accessoryCategories = [];

  void init(AccessoryCategory? initialAccessoryCategory) {
    accessoryCategories = dataService.accessoryCategories;
    selectedAccessoryCategory = initialAccessoryCategory;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
