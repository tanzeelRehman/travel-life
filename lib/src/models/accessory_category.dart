// import 'dart:convert';

class AccessoryCategory {
  final int? id;
  final String? name;
  final DateTime? createdAt;
  AccessoryCategory({
    this.id,
    this.name,
    this.createdAt,
  });

  AccessoryCategory copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
  }) {
    return AccessoryCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory AccessoryCategory.fromMap(Map<String, dynamic> map) {
    return AccessoryCategory(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['category'] != null ? map['category'] as String : null,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory CostCategory.fromJson(String source) =>
  //     CostCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<AccessoryCategory>? fromJsonList(
      List<Map<String, dynamic>>? jsonList) {
    return jsonList?.map((json) => AccessoryCategory.fromMap(json)).toList();
  }

  @override
  String toString() =>
      'CostCategory(id: $id, name: $name, createdAt: $createdAt)';

  @override
  bool operator ==(covariant AccessoryCategory other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ createdAt.hashCode;
}
