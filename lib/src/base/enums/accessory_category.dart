import 'package:starter_app/generated/assets.dart';

enum AccessoryCategory {
  riding_gear,
  safety_gear,
  maintenance_and_tools,
  performance_upgrades,
  comfort_and_convenience,
  security_and_protection,
  customization,
  electronics_and_gadgets,
  other,
}

String getReadableAccessoryCategory(AccessoryCategory category) {
  switch (category) {
    case AccessoryCategory.riding_gear:
      return 'Riding Gear';
    case AccessoryCategory.safety_gear:
      return 'Safety Gear';
    case AccessoryCategory.maintenance_and_tools:
      return 'Maintenance and Tools';
    case AccessoryCategory.performance_upgrades:
      return 'Performance Upgrades';
    case AccessoryCategory.comfort_and_convenience:
      return 'Comfort and Convenience';
    case AccessoryCategory.security_and_protection:
      return 'Security and Protection';
    case AccessoryCategory.customization:
      return 'Customization';
    case AccessoryCategory.electronics_and_gadgets:
      return 'Electronics and Gadgets';
    case AccessoryCategory.other:
      return 'Other';
    default:
      throw ArgumentError('Invalid accessory category: $category');
  }
}

AccessoryCategory getAccessoryCategoryFromReadable(String text) {
  switch (text.toLowerCase()) {
    case 'riding gear':
      return AccessoryCategory.riding_gear;
    case 'safety gear':
      return AccessoryCategory.safety_gear;
    case 'maintenance and tools':
      return AccessoryCategory.maintenance_and_tools;
    case 'performance upgrades':
      return AccessoryCategory.performance_upgrades;
    case 'comfort and convenience':
      return AccessoryCategory.comfort_and_convenience;
    case 'security and protection':
      return AccessoryCategory.security_and_protection;
    case 'customization':
      return AccessoryCategory.customization;
    case 'electronics and gadgets':
      return AccessoryCategory.electronics_and_gadgets;
    case 'other':
      return AccessoryCategory.other;
    default:
      throw ArgumentError('Invalid accessory category text: $text');
  }
}

String getIconOfAccessoryCategory(AccessoryCategory category) {
  switch (category) {
    case AccessoryCategory.riding_gear:
      return AssetIcons.acRidingGear;
    case AccessoryCategory.safety_gear:
      return AssetIcons.acSafetyGear;
    case AccessoryCategory.maintenance_and_tools:
      return AssetIcons.acMaintainanceAndTools;
    case AccessoryCategory.performance_upgrades:
      return AssetIcons.acPerformanceUpgrades;
    case AccessoryCategory.comfort_and_convenience:
      return AssetIcons.acComfortAndConvenience;
    case AccessoryCategory.security_and_protection:
      return AssetIcons.acSecurityAndProtection;
    case AccessoryCategory.customization:
      return AssetIcons.acCustomization;
    case AccessoryCategory.electronics_and_gadgets:
      return AssetIcons.acElectronicsAndGadgets;
    case AccessoryCategory.other:
      return AssetIcons.acOthers;
    default:
      throw ArgumentError('Invalid accessory category: $category');
  }
}
