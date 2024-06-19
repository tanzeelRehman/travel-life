import 'package:starter_app/src/models/app_user.dart';

class Event {
  final int? id;
  final DateTime? createdAt;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? noOfDays;
  final AppUser? organizer;
  final String? name;
  final String? description;
  final String? destination;
  final dynamic destLat;
  final dynamic destLong;
  final String? coverImage;

  Event({
    this.createdAt,
    this.id,
    this.name,
    this.description,
    this.coverImage,
    this.organizer,
    this.destination,
    this.noOfDays,
    this.startTime,
    this.endTime,
    this.destLat,
    this.destLong,
  });

  Event copyWith({
    DateTime? createdAt,
    int? id,
    String? name,
    String? description,
    String? groupImage,
    AppUser? admin,
    String? destination,
    int? noOfDays,
    DateTime? startTime,
    DateTime? endTime,
    double? destLat,
    double? destLong,
  }) {
    return Event(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      coverImage: groupImage ?? this.coverImage,
      organizer: admin ?? this.organizer,
      destination: destination ?? this.destination,
      noOfDays: noOfDays ?? this.noOfDays,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      destLat: destLat ?? this.destLat,
      destLong: destLong ?? this.destLong,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'organizer': organizer?.id,
      'destination': destination,
      'start_time': startTime?.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'no_of_days': noOfDays,
      'dest_lat': destLat,
      'dest_long': destLong,
    };
  }

  Map<String, dynamic> insertToMap() {
    return <String, dynamic>{
      // 'id': id,
      'name': name,
      'description': description,
      'organizer': organizer?.id,
      'destination': destination,
      'start_time': startTime?.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'no_of_days': noOfDays,
      'dest_lat': destLat,
      'dest_long': destLong,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      coverImage:
          map['cover_image'] != null ? map['cover_image'] as String : null,
      organizer: map['organizer'] != null
          ? AppUser.fromMap(map['organizer'] as Map<String, dynamic>)
          : null,
      destination:
          map['destination'] != null ? map['destination'] as String : null,
      destLat: map['dest_lat'],
      destLong: map['dest_long'],
      noOfDays: map['no_of_days'] != null ? map['no_of_days'] as int : null,
      startTime: map['start_time'] != null
          ? DateTime.parse(map['start_time'] as String)
          : null,
      endTime: map['end_time'] != null
          ? DateTime.parse(map['end_time'] as String)
          : null,
    );
  }

  @override
  String toString() {
    return 'Event(created_at: $createdAt, id: $id, name: $name, description: $description, group_image: $coverImage, admin: $organizer, location_city: $destination)';
  }

  @override
  bool operator ==(covariant Event other) {
    if (identical(this, other)) return true;

    return other.createdAt == createdAt &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.coverImage == coverImage &&
        other.organizer == organizer &&
        other.destination == destination;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
        id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        coverImage.hashCode ^
        organizer.hashCode ^
        destination.hashCode;
  }

  static List<Event>? fromJsonList(List<Map<String, dynamic>>? jsonList) {
    return jsonList?.map((json) => Event.fromMap(json)).toList();
  }
}
