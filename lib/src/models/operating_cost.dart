import 'package:starter_app/src/models/cost_category.dart';
import 'package:starter_app/src/models/vehicle.dart';

class OperatingCost {
  final int? id;
  final DateTime? createdAt;
  final Vehicle? vehicle; //fk
  final String? user; //fk
  final CostCategory? category; //fk
  final String? description;
  final DateTime? purchaseDate;
  final double? purchasePrice;
  final double? vat;
  final double? total;
  final String? attachment;
  final String? height;
  final String? width;

  OperatingCost({
    this.id,
    this.createdAt,
    this.vehicle,
    this.user,
    this.category,
    this.description,
    this.purchaseDate,
    this.purchasePrice,
    this.vat,
    this.total,
    this.attachment,
    this.height,
    this.width,
  });

  factory OperatingCost.fromMap(Map<String, dynamic> json) => OperatingCost(
        id: json['id'] as int?,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null,
        vehicle: json['vehicle'] != null
            ? Vehicle.fromMap(json['vehicle'] as Map<String, dynamic>)
            : null,
        user: json['user'] as String?,
        category: json['category'] != null
            ? CostCategory.fromMap(json['category'] as Map<String, dynamic>)
            : null,
        description: json['description'] as String?,
        purchaseDate: json['purchase_date'] != null
            ? DateTime.parse(json['purchase_date'] as String)
            : null,
        purchasePrice: json['purchase_price'] as double?,
        vat: json['vat'] as double?,
        total: json['total'] as double?,
        attachment: json['attachment'] as String?,
        height: json['height'] as String?,
        width: json['width'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'vehicle': vehicle?.id,
        'user': user,
        'category': category?.id,
        'description': description,
        'purchase_date': purchaseDate?.toIso8601String(),
        'purchase_price': purchasePrice,
        'vat': vat,
        'total': total,
        'attachment': attachment,
        'height': height,
        'width': width,
      };

  Map<String, dynamic> insertToMap() => {
        // 'id': id,
        // 'created_at': createdAt?.toIso8601String(),
        'vehicle': vehicle?.id,
        'user': user,
        'category': category?.id,
        'description': description,
        'purchase_date': purchaseDate?.toIso8601String(),
        'purchase_price': purchasePrice,
        'vat': vat,
        'total': total,
        'attachment': attachment,
        'height': height,
        'width': width,
      };

  static List<OperatingCost>? fromJsonList(
      List<Map<String, dynamic>>? jsonList) {
    return jsonList?.map((json) => OperatingCost.fromMap(json)).toList();
  }

  OperatingCost copyWith({
    int? id,
    DateTime? createdAt,
    Vehicle? vehicle,
    String? user,
    CostCategory? category,
    String? description,
    DateTime? purchaseDate,
    double? purchasePrice,
    double? vat,
    double? total,
    String? attachment,
    String? height,
    String? width,
  }) {
    return OperatingCost(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      vehicle: vehicle ?? this.vehicle,
      user: user ?? this.user,
      category: category ?? this.category,
      description: description ?? this.description,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      vat: vat ?? this.vat,
      total: total ?? this.total,
      attachment: attachment ?? this.attachment,
      height: height ?? this.height,
      width: width ?? this.width,
    );
  }
}
