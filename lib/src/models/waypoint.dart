import 'package:starter_app/src/models/app_user.dart';

class Waypoint {
  final int? id;
  final int? event;
  final DateTime? createdAt;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? noOfDays;
  final AppUser? addedBy;
  final String? label;
  final dynamic lat;
  final dynamic long;

  Waypoint({
    this.createdAt,
    this.id,
    this.event,
    this.label,
    this.addedBy,
    this.noOfDays,
    this.startTime,
    this.endTime,
    this.lat,
    this.long,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'event': event,
      'label': label,
      'added_by': addedBy?.id,
      'start_time': startTime?.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'no_of_days': noOfDays,
      'lat': lat,
      'long': long,
    };
  }

  Map<String, dynamic> insertToMap() {
    return <String, dynamic>{
      // 'id': id,
      'label': label,
      'event': event,
      'start_time': startTime?.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'no_of_days': noOfDays,
      'lat': lat,
      'long': long,
      'added_by': addedBy?.id
    };
  }

  factory Waypoint.fromMap(Map<String, dynamic> map) {
    return Waypoint(
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      id: map['id'] != null ? map['id'] as int : null,
      label: map['label'] != null ? map['label'] as String : null,
      addedBy: map['added_by'] != null
          ? AppUser.fromMap(map['added_by'] as Map<String, dynamic>)
          : null,
      event: map['event'] != null ? map['event'] as int : null,
      lat: map['lat'],
      long: map['long'],
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
  bool operator ==(covariant Waypoint other) {
    if (identical(this, other)) return true;

    return other.createdAt == createdAt &&
        other.id == id &&
        other.label == label &&
        other.addedBy == addedBy;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^ id.hashCode ^ label.hashCode ^ addedBy.hashCode;
  }

  static List<Waypoint>? fromJsonList(List<Map<String, dynamic>>? jsonList) {
    return jsonList?.map((json) => Waypoint.fromMap(json)).toList();
  }
}
