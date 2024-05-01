// import 'dart:convert';

class Manufacturor {
  final int? id;
  final DateTime? createdAt;
  final String? name;
  final String? avatar;
  final int? idCarMake;
  final int? vehicleType;
  Manufacturor({
    this.id,
    this.createdAt,
    this.name,
    this.avatar,
    this.idCarMake,
    this.vehicleType,
  });

  Manufacturor copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    String? avatar,
    int? idCarMake,
    int? vehicleType,
  }) {
    return Manufacturor(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      idCarMake: idCarMake ?? this.idCarMake,
      vehicleType: vehicleType ?? this.vehicleType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'manufacturer': name,
      'avatar': avatar,
      'id_car_make': idCarMake,
      'vehicle_type': vehicleType,
    };
  }

  factory Manufacturor.fromMap(Map<String, dynamic> map) {
    return Manufacturor(
      id: map['id'] != null ? map['id'] as int : null,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      name: map['manufacturer'] != null ? map['manufacturer'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      idCarMake: map['id_car_make'] != null ? map['id_car_make'] as int : null,
      vehicleType:
          map['vehicle_type'] != null ? map['vehicle_type'] as int : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Manufacturor.fromJson(String source) =>
  //     Manufacturor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Manufacturor(id: $id, createdAt: $createdAt, name: $name, avatar: $avatar, idCarMake: $idCarMake, vehicleType: $vehicleType)';
  }

  @override
  bool operator ==(covariant Manufacturor other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.name == name &&
        other.avatar == avatar &&
        other.idCarMake == idCarMake &&
        other.vehicleType == vehicleType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        name.hashCode ^
        avatar.hashCode ^
        idCarMake.hashCode ^
        vehicleType.hashCode;
  }

  static List<Manufacturor>? fromJsonList(
      List<Map<String, dynamic>>? jsonList) {
    return jsonList?.map((json) => Manufacturor.fromMap(json)).toList();
  }
}
