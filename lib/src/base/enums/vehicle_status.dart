enum VehicleStatus { active, inactive }

String getReadableVehicleStatus(VehicleStatus status) {
  switch (status) {
    case VehicleStatus.active:
      return 'Active';
    case VehicleStatus.inactive:
      return 'Inactive';
    default:
      throw ArgumentError('Invalid vehicle status: $status');
  }
}

VehicleStatus getVehicleStatusFromReadable(String text) {
  switch (text.toLowerCase()) {
    case 'active':
      return VehicleStatus.active;
    case 'inactive':
      return VehicleStatus.inactive;
    default:
      throw ArgumentError('Invalid vehicle status text: $text');
  }
}
