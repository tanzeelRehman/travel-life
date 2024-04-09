import 'package:starter_app/src/models/accessory_category.dart';
import 'package:starter_app/src/models/vehicle.dart';

class Accessory {
  final int? id;
  final DateTime? createdAt;
  final Vehicle? vehicle; //fk
  final String? user; //fk
  final AccessoryCategory? category; //fk
  final String? description;
  final DateTime? purchaseDate;
  final dynamic purchasePrice;
  final dynamic vat;
  final dynamic total;
  final String? invoiceAttachment;
  final String? height;
  final String? width;
  final String? accessoryImageAttachment;

  Accessory({
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
    this.invoiceAttachment,
    this.height,
    this.width,
    this.accessoryImageAttachment,
  });

  factory Accessory.fromMap(Map<String, dynamic> json) => Accessory(
        id: json['id'] as int?,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null,
        vehicle:
            json['vehicle'] != null ? Vehicle.fromMap(json['vehicle']) : null,
        user: json['user'] as String?,
        category: json['category'] != null
            ? AccessoryCategory.fromMap(json['category'])
            : null,
        description: json['description'] as String?,
        purchaseDate: json['purchase_date'] != null
            ? DateTime.parse(json['purchase_date'] as String)
            : null,
        purchasePrice: json['purchase_price'],
        vat: json['vat'],
        total: json['total'],
        invoiceAttachment: json['invoice_attachment'] as String?,
        height: json['height'] as String?,
        width: json['width'] as String?,
        accessoryImageAttachment: json['accessoryimage_attachment'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        // 'created_at': createdAt?.toIso8601String(),
        'vehicle': vehicle?.id,
        'user': user,
        'category': category?.id,
        'description': description,
        'purchase_date': purchaseDate?.toIso8601String(),
        'purchase_price': purchasePrice,
        'vat': vat,
        'total': total,
        // 'invoice_attachment': invoiceAttachment,
        'height': height,
        'width': width,
        // 'accessoryimage_attachment': accessoryImageAttachment,
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
        // 'invoice_attachment': invoiceAttachment,
        'height': height,
        'width': width,
        // 'accessoryimage_attachment':
        //     accessoryImageAttachment, //might also remove this idk
      };

  Accessory copyWith({
    int? id,
    DateTime? createdAt,
    Vehicle? vehicle,
    String? user,
    AccessoryCategory? category,
    String? description,
    DateTime? purchaseDate,
    dynamic purchasePrice,
    dynamic vat,
    dynamic total,
    String? invoiceAttachment,
    String? height,
    String? width,
    String? accessoryImageAttachment,
  }) {
    return Accessory(
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
      invoiceAttachment: invoiceAttachment ?? this.invoiceAttachment,
      height: height ?? this.height,
      width: width ?? this.width,
      accessoryImageAttachment:
          accessoryImageAttachment ?? this.accessoryImageAttachment,
    );
  }

  static List<Accessory>? fromJsonList(List<Map<String, dynamic>>? jsonList) {
    return jsonList?.map((json) => Accessory.fromMap(json)).toList();
  }
}
