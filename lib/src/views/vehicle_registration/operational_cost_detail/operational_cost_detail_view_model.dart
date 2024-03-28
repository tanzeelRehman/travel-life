import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/operational_cost_category.dart';

class OperationalCostDetailViewModel extends ReactiveViewModel {
  DateTime? purchaseDate;
  OperationalCostCategory? category;

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController purchasePriceController = TextEditingController();

  final TextEditingController vatController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  init() {}

  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
    purchasePriceController.dispose();
    vatController.dispose();
    priceController.dispose();
  }
}
