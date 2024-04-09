import 'package:stacked/stacked.dart';
import 'package:starter_app/src/models/cost_category.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';

class CostCategoryDialogViewModel extends ReactiveViewModel with DataViewModel {
  CostCategory? selectedCostCategory;

  onChangeCostCategory(CostCategory? v) {
    if (v != null) {
      selectedCostCategory = v;
      notifyListeners();
    }
  }

  List<CostCategory> costCategories = [];

  void init(CostCategory? category) {
    costCategories = dataService.costCategories;
    selectedCostCategory = category;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
