import 'package:starter_app/generated/assets.dart';

enum OperationalCostCategory {
  vehicle_service,
  repairs,
  vehicle_licenses,
  tires,
  insurance,
  others,
}

String getReadableOperationalCostCategory(OperationalCostCategory category) {
  switch (category) {
    case OperationalCostCategory.vehicle_service:
      return 'Vehicle Service';
    case OperationalCostCategory.repairs:
      return 'Repairs';
    case OperationalCostCategory.vehicle_licenses:
      return 'Vehicle Licenses';
    case OperationalCostCategory.tires:
      return 'Tires';
    case OperationalCostCategory.insurance:
      return 'Insurance';
    case OperationalCostCategory.others:
      return 'Others';
    default:
      throw ArgumentError('Invalid operational cost category: $category');
  }
}

String getIconOfOperationalCostCategory(OperationalCostCategory category) {
  switch (category) {
    case OperationalCostCategory.vehicle_service:
      return AssetImages.opcVehicleService;
    case OperationalCostCategory.repairs:
      return AssetImages.opcRepairs;
    case OperationalCostCategory.vehicle_licenses:
      return AssetImages.opcVehicleLiscenses;
    case OperationalCostCategory.tires:
      return AssetImages.opcTires;
    case OperationalCostCategory.insurance:
      return AssetImages.opcInsurance;
    case OperationalCostCategory.others:
      return AssetImages.opcOthers;
    default:
      throw ArgumentError('Invalid operational cost category: $category');
  }
}

OperationalCostCategory getOperationalCostCategoryFromReadable(String text) {
  switch (text.toLowerCase()) {
    case 'vehicle service':
      return OperationalCostCategory.vehicle_service;
    case 'repairs':
      return OperationalCostCategory.repairs;
    case 'vehicle licenses':
      return OperationalCostCategory.vehicle_licenses;
    case 'tires':
      return OperationalCostCategory.tires;
    case 'insurance':
      return OperationalCostCategory.insurance;
    case 'others':
      return OperationalCostCategory.others;
    default:
      throw ArgumentError('Invalid operational cost category text: $text');
  }
}
