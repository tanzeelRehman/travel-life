import 'package:starter_app/src/models/manufacturor.dart';

class VehicleModel {
  final int? id;
  final DateTime? createdAt;
  final Manufacturor? manufacturer; //fk
  final String? model;
  final String? avatar;
  final int? idCarMake;
  final int? idCarModel;
  final int? idCarType;
  VehicleModel({
    this.id,
    this.createdAt,
    this.manufacturer,
    this.model,
    this.avatar,
    this.idCarMake,
    this.idCarModel,
    this.idCarType,
  });

  VehicleModel copyWith({
    int? id,
    DateTime? createdAt,
    Manufacturor? manufacturer,
    String? model,
    String? avatar,
    int? idCarMake,
    int? idCarModel,
    int? idCarType,
  }) {
    return VehicleModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      avatar: avatar ?? this.avatar,
      idCarMake: idCarMake ?? this.idCarMake,
      idCarModel: idCarModel ?? this.idCarModel,
      idCarType: idCarType ?? this.idCarType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'manufacturer': manufacturer,
      'model': model,
      'avatar': avatar,
      'id_car_make': idCarMake,
      'id_car_model': idCarModel,
      'id_car_type': idCarType,
    };
  }

  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    return VehicleModel(
      id: map['id'] != null ? map['id'] as int : null,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      manufacturer: map['manufacturer'] != null
          ? Manufacturor.fromMap(map['manufacturer'])
          : null,
      model: map['model'] != null ? map['model'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      idCarMake: map['id_car_make'] != null ? map['id_car_make'] as int : null,
      idCarModel:
          map['id_car_model'] != null ? map['id_car_model'] as int : null,
      idCarType: map['id_car_type'] != null ? map['id_car_type'] as int : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory VehicleModel.fromJson(String source) =>
  //     VehicleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VehicleModel(id: $id, created_at: $createdAt, manufacturer: $manufacturer, model: $model, avatar: $avatar, id_car_make: $idCarMake, id_car_model: $idCarModel, id_car_type: $idCarType)';
  }

  @override
  bool operator ==(covariant VehicleModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.manufacturer == manufacturer &&
        other.model == model &&
        other.avatar == avatar &&
        other.idCarMake == idCarMake &&
        other.idCarModel == idCarModel &&
        other.idCarType == idCarType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        manufacturer.hashCode ^
        model.hashCode ^
        avatar.hashCode ^
        idCarMake.hashCode ^
        idCarModel.hashCode ^
        idCarType.hashCode;
  }

  static List<VehicleModel>? fromJsonList(
      List<Map<String, dynamic>>? jsonList) {
    return jsonList?.map((json) => VehicleModel.fromMap(json)).toList();
  }
}
