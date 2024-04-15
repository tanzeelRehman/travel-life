// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:starter_app/src/base/enums/vehicle_status.dart';
import 'package:starter_app/src/models/manufacturor.dart';
import 'package:starter_app/src/models/vehicle_model.dart';

class Vehicle {
  final int? id;
  final DateTime? createdAt;
  final String? number;
  final String? user; //fk
  final Manufacturor? manufacturer; //fk
  final VehicleModel? model; //fk
  final String? description;
  final bool? primaryVehicle;
  final bool? inUse;
  final DateTime? purchaseDate;
  final dynamic price;
  final String? photoURL;
  final String? regNo;
  final String? vinNo;
  final String? tankCapacity;
  final int? serviceInterval;
  final DateTime? lastService;
  final int? dailyDistance;
  final String? tireFront;
  final String? tireRear;
  final int? odometer;
  final VehicleStatus? status;
  final int? manufactureYear;
  final int? idCarMake;
  final String? horsepower;
  final int? idCarModel;
  final int? consumption;
  final int? warrantyPeriod;
  final DateTime? warrantyExpiryDate;
  final int? vehicleType;

  Vehicle({
    this.id,
    this.createdAt,
    this.number,
    this.user,
    this.manufacturer,
    this.model,
    this.description,
    this.primaryVehicle,
    this.inUse,
    this.purchaseDate,
    this.price,
    this.photoURL,
    this.regNo,
    this.vinNo,
    this.tankCapacity,
    this.serviceInterval,
    this.lastService,
    this.dailyDistance,
    this.tireFront,
    this.tireRear,
    this.odometer,
    this.status,
    this.manufactureYear,
    this.idCarMake,
    this.horsepower,
    this.idCarModel,
    this.consumption,
    this.warrantyPeriod,
    this.warrantyExpiryDate,
    this.vehicleType,
  });

  factory Vehicle.fromMap(Map<String, dynamic> json) => Vehicle(
        id: json['id'] as int?,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null,
        number: json['number'] as String?,
        user: json['user'] as String?,
        manufacturer: json['manufacturer'] != null
            ? Manufacturor.fromMap(json['manufacturer'] as Map<String, dynamic>)
            : null,
        model:
            json['model'] != null ? VehicleModel.fromMap(json['model']) : null,
        description: json['description'] as String?,
        primaryVehicle: json['primary_vehicle'] as bool?,
        inUse: json['in_use'] as bool?,
        purchaseDate: json['purchase_date'] != null
            ? DateTime.parse(json['purchase_date'] as String)
            : null,
        price: json['price'],
        photoURL: json['photoURL'] as String?,
        regNo: json['reg_no'] as String?,
        vinNo: json['vin_no'] as String?,
        tankCapacity: json['tank_capacity'] as String?,
        serviceInterval: json['service_interval'] as int?,
        lastService: json['last_service'] != null
            ? DateTime.parse(json['last_service'] as String)
            : null,
        dailyDistance: json['daily_distance'] as int?,
        tireFront: json['tire_front'] as String?,
        tireRear: json['tire_rear'] as String?,
        odometer: json['odometer'] as int?,
        status: json['status'] != null
            ? getVehicleStatusFromReadable(json['status'] as String)
            : null,
        manufactureYear: json['manufacture_year'] as int?,
        idCarMake: json['id_car_make'] as int?,
        horsepower: json['horsepower'] as String?,
        idCarModel: json['id_car_model'] as int?,
        consumption: json['consumption'] as int?,
        warrantyPeriod: json['warranty_period'] as int?,
        warrantyExpiryDate: json['warranty_expiry_date'] != null
            ? DateTime.parse(json['warranty_expiry_date'] as String)
            : null,
        vehicleType: json['vehicle_type'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        // 'created_at': createdAt?.toIso8601String(),
        // 'reg_no': number,
        'user': user,
        'manufacturer': manufacturer?.id,
        'model': model?.id,
        'description': description,
        'primary_vehicle': primaryVehicle,
        'in_use': inUse,
        'purchase_date': purchaseDate?.toIso8601String(),
        'price': price,
        if (photoURL != null && photoURL != '') 'photoURL': photoURL,
        'reg_no': regNo,
        'vin_no': vinNo,
        'tank_capacity': tankCapacity,
        'service_interval': serviceInterval,
        'last_service': lastService?.toIso8601String(),
        'daily_distance': dailyDistance,
        'tire_front': tireFront,
        'tire_rear': tireRear,
        'odometer': odometer,
        'status': status != null ? getReadableVehicleStatus(status!) : null,
        'manufacture_year': manufactureYear,
        'id_car_make': idCarMake,
        'horsepower': horsepower,
        'id_car_model': idCarModel,
        'consumption': consumption,
        'warranty_period': warrantyPeriod,
        'warranty_expiry_date': warrantyExpiryDate?.toIso8601String(),
        'vehicle_type': vehicleType,
        // 'description': description,
      };

  Map<String, dynamic> insertToMap() => {
        // 'id': id,
        // 'created_at': createdAt?.toIso8601String(),
        // 'number': number,
        'user': user,
        'manufacturer': manufacturer?.id,
        'model': model?.id,
        'description': description,
        'primary_vehicle': primaryVehicle,
        'in_use': inUse,
        'purchase_date': purchaseDate?.toIso8601String(),
        'price': price?.toDouble(),
        'photoURL': photoURL,
        'reg_no': regNo,
        'vin_no': vinNo,
        'tank_capacity': tankCapacity,
        'service_interval': serviceInterval,
        'last_service': lastService?.toIso8601String(),
        'daily_distance': dailyDistance,
        'tire_front': tireFront,
        'tire_rear': tireRear,
        'odometer': odometer,
        // 'status': status,
        'status': status != null ? getReadableVehicleStatus(status!) : null,
        'manufacture_year': manufactureYear,
        'id_car_make': idCarMake,
        'horsepower': horsepower,
        'id_car_model': idCarModel,
        'consumption': consumption,
        'warranty_period': warrantyPeriod,
        'warranty_expiry_date': warrantyExpiryDate?.toIso8601String(),
        'vehicle_type': vehicleType,
      };

  static List<Vehicle>? fromJsonList(List<Map<String, dynamic>>? jsonList) {
    return jsonList?.map((json) => Vehicle.fromMap(json)).toList();
  }

  Vehicle copyWith({
    int? id,
    DateTime? createdAt,
    String? number,
    String? user,
    String? description,
    bool? primaryVehicle,
    bool? inUse,
    DateTime? purchaseDate,
    double? price,
    String? photoURL,
    String? regNo,
    String? vinNo,
    String? tankCapacity,
    int? serviceInterval,
    DateTime? lastService,
    int? dailyDistance,
    String? tireFront,
    String? tireRear,
    int? odometer,
    VehicleStatus? status,
    int? manufactureYear,
    int? idCarMake,
    String? horsepower,
    int? idCarModel,
    int? consumption,
    int? warrantyPeriod,
    DateTime? warrantyExpiryDate,
    int? vehicleType,
    Manufacturor? manufacturer,
    VehicleModel? model,
  }) {
    return Vehicle(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      number: number ?? this.number,
      user: user ?? this.user,
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      description: description ?? this.description,
      primaryVehicle: primaryVehicle ?? this.primaryVehicle,
      inUse: inUse ?? this.inUse,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      price: price ?? this.price,
      photoURL: photoURL ?? this.photoURL,
      regNo: regNo ?? this.regNo,
      vinNo: vinNo ?? this.vinNo,
      tankCapacity: tankCapacity ?? this.tankCapacity,
      serviceInterval: serviceInterval ?? this.serviceInterval,
      lastService: lastService ?? this.lastService,
      dailyDistance: dailyDistance ?? this.dailyDistance,
      tireFront: tireFront ?? this.tireFront,
      tireRear: tireRear ?? this.tireRear,
      odometer: odometer ?? this.odometer,
      status: status ?? this.status,
      manufactureYear: manufactureYear ?? this.manufactureYear,
      idCarMake: idCarMake ?? this.idCarMake,
      horsepower: horsepower ?? this.horsepower,
      idCarModel: idCarModel ?? this.idCarModel,
      consumption: consumption ?? this.consumption,
      warrantyPeriod: warrantyPeriod ?? this.warrantyPeriod,
      warrantyExpiryDate: warrantyExpiryDate ?? this.warrantyExpiryDate,
      vehicleType: vehicleType ?? this.vehicleType,
    );
  }

  @override
  String toString() {
    return 'Vehicle(id: $id, createdAt: $createdAt, number: $number, user: $user, manufacturer: $manufacturer, model: $model, description: $description, primaryVehicle: $primaryVehicle, inUse: $inUse, purchaseDate: $purchaseDate, price: $price, photoURL: $photoURL, regNo: $regNo, vinNo: $vinNo, tankCapacity: $tankCapacity, serviceInterval: $serviceInterval, lastService: $lastService, dailyDistance: $dailyDistance, tireFront: $tireFront, tireRear: $tireRear, odometer: $odometer, status: $status, manufactureYear: $manufactureYear, idCarMake: $idCarMake, horsepower: $horsepower, idCarModel: $idCarModel, consumption: $consumption, warrantyPeriod: $warrantyPeriod, warrantyExpiryDate: $warrantyExpiryDate, vehicleType: $vehicleType)';
  }
}
