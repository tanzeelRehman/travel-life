// import 'package:starter_app/src/models/app_user.dart';

// class JoinRequestUser {
//   final AppUser? user;
//   final DateTime? joinRequestTime;
//   JoinRequestUser({
//     this.user,
//     this.joinRequestTime,
//   });

//   JoinRequestUser copyWith({
//     AppUser? user,
//     DateTime? joinRequestTime,
//   }) {
//     return JoinRequestUser(
//       user: user ?? this.user,
//       joinRequestTime: joinRequestTime ?? this.joinRequestTime,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'user': user?.toMap(),
//       'join_request_time': joinRequestTime?.toIso8601String(),
//     };
//   }

//   factory JoinRequestUser.fromMap(Map<String, dynamic> map) {
//     return JoinRequestUser(
//       user: map['user'] != null
//           ? AppUser.fromMap(map['user'] as Map<String, dynamic>)
//           : null,
//       joinRequestTime: map['join_request_time'] != null
//           ? DateTime.parse(map['join_request_time'] as String)
//           : null,
//     );
//   }

//   @override
//   String toString() =>
//       'JoinRequestUser(user: $user, joinRequestTime: $joinRequestTime)';

//   @override
//   bool operator ==(covariant JoinRequestUser other) {
//     if (identical(this, other)) return true;

//     return other.user == user && other.joinRequestTime == joinRequestTime;
//   }

//   @override
//   int get hashCode => user.hashCode ^ joinRequestTime.hashCode;

//   static List<JoinRequestUser>? fromJsonList(List<dynamic>? jsonList) {
//     return jsonList?.map((e) => JoinRequestUser.fromMap(e)).toList();
//   }
// }
