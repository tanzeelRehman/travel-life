import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/models/manufacturor.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';

class ManufacturerBottomSheetViewModel extends ReactiveViewModel
    with DataViewModel {
  List<Manufacturor> allManufacturers = [];

  List<Manufacturor> manufacturers = [];

  void init() {
    allManufacturers = dataService.manufacturors;
    manufacturers = allManufacturers;
    notifyListeners();
  }

  final TextEditingController searchController = TextEditingController();

  onSearch(String? query) {
    if (query == null || query.isEmpty) {
      manufacturers = allManufacturers;
    } else {
      manufacturers = allManufacturers
          .where(
            (manufacturer) => manufacturer.name!.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
