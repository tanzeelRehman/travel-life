import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/vehicle_status.dart';

class VehicleStatusButtonModel {
  final VehicleStatus status;
  final String iconPath;

  VehicleStatusButtonModel({required this.status, required this.iconPath});
}

List<VehicleStatusButtonModel> vehicleStatusButtons = [
  VehicleStatusButtonModel(
    status: VehicleStatus.active,
    iconPath: AssetIcons.statusActive,
  ),
  VehicleStatusButtonModel(
    status: VehicleStatus.inactive,
    iconPath: AssetIcons.statusInActive,
  ),
];
