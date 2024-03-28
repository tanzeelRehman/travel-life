import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/enums/accessory_category.dart';

class AccessoryDetailViewModel extends ReactiveViewModel {
  DateTime? purchaseDate;
  AccessoryCategory? category;

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
