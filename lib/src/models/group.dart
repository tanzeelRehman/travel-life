import 'package:starter_app/src/models/app_user.dart';

class Group {
  final DateTime? createdAt;
  final int? id;
  final String? name;
  final String? description;
  final String? groupImage;
  final AppUser? admin;
  final bool? isPublic;
  final int? maxMembers;
  final String? locationCity;
  final bool? isEnabled;
  final int? totalMembers;

  Group({
    this.createdAt,
    this.id,
    this.name,
    this.description,
    this.groupImage,
    this.admin,
    this.isPublic,
    this.maxMembers,
    this.locationCity,
    this.isEnabled,
    this.totalMembers,
  });

  Group copyWith({
    DateTime? createdAt,
    int? id,
    String? name,
    String? description,
    String? groupImage,
    AppUser? admin,
    bool? isPublic,
    int? maxMembers,
    String? locationCity,
    bool? isEnabled,
    int? totalMembers,
  }) {
    return Group(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      groupImage: groupImage ?? this.groupImage,
      admin: admin ?? this.admin,
      isPublic: isPublic ?? this.isPublic,
      maxMembers: maxMembers ?? this.maxMembers,
      locationCity: locationCity ?? this.locationCity,
      isEnabled: isEnabled ?? this.isEnabled,
      totalMembers: totalMembers ?? this.totalMembers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'created_at': createdAt?.toIso8601String(),
      'id': id,
      'name': name,
      'description': description,
      // 'group_image': groupImage,
      'admin': admin?.id,
      'is_public': isPublic,
      'max_members': maxMembers,
      'location_city': locationCity,
      'is_enabled': isEnabled,
    };
  }

  Map<String, dynamic> insertToMap() {
    return <String, dynamic>{
      // 'created_at': createdAt?.toIso8601String(),
      // 'id': id,
      'name': name,
      'description': description,
      // 'group_image': groupImage,
      'admin': admin?.id,
      'is_public': isPublic,
      'max_members': maxMembers,
      'location_city': locationCity,
      'is_enabled': isEnabled,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      groupImage:
          map['group_image'] != null ? map['group_image'] as String : null,
      admin: map['admin'] != null
          ? AppUser.fromMap(map['admin'] as Map<String, dynamic>)
          : null,
      isPublic: map['is_public'] != null ? map['is_public'] as bool : null,
      maxMembers: map['max_members'] != null ? map['max_members'] as int : null,
      locationCity:
          map['location_city'] != null ? map['location_city'] as String : null,
      isEnabled: map['is_enabled'] != null ? map['is_enabled'] as bool : null,
    );
  }

  @override
  String toString() {
    return 'Group(created_at: $createdAt, id: $id, name: $name, description: $description, group_image: $groupImage, admin: $admin, is_public: $isPublic, max_members: $maxMembers, location_city: $locationCity, is_enabled: $isEnabled)';
  }

  @override
  bool operator ==(covariant Group other) {
    if (identical(this, other)) return true;

    return other.createdAt == createdAt &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.groupImage == groupImage &&
        other.admin == admin &&
        other.isPublic == isPublic &&
        other.maxMembers == maxMembers &&
        other.isEnabled == isEnabled &&
        other.locationCity == locationCity;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
        id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        groupImage.hashCode ^
        admin.hashCode ^
        isPublic.hashCode ^
        maxMembers.hashCode ^
        isEnabled.hashCode ^
        locationCity.hashCode;
  }

  static List<Group>? fromJsonList(List<Map<String, dynamic>>? jsonList) {
    return jsonList?.map((json) => Group.fromMap(json)).toList();
  }

  static Group dummyGroup = Group(
    createdAt: DateTime.now(),
    admin: AppUser(
      firstname: 'dummy user',
    ),
    name: 'dummy group',
    groupImage: 'https://avatars.githubusercontent.com/u/69142783?v=4',
  );
}
