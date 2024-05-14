import 'dart:convert';

class AppUser {
  final String? id;
  final String? user; // user id from supabase auth table (FK)
  final String? avatar;
  final String? bio;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? dob;
  final int? age;
  final String? ridingExperience;
  final String? gender;
  final String? bloodGroup;
  final String? mobile;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? zip;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? alias;
  final String? website;
  final String? latLng;
  final String? currency;
  final String? nextOfKin;
  final int? nextOfKinMobile;
  final bool? currentlyLoggedIn;

  AppUser({
    this.id,
    this.user,
    this.avatar,
    this.bio,
    this.createdAt,
    this.updatedAt,
    this.dob,
    this.age,
    this.ridingExperience,
    this.gender,
    this.bloodGroup,
    this.mobile,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zip,
    this.firstname,
    this.lastname,
    this.email,
    this.alias,
    this.website,
    this.latLng,
    this.currency,
    this.nextOfKin,
    this.nextOfKinMobile,
    this.currentlyLoggedIn,
  });

  AppUser copyWith({
    String? id,
    String? user,
    String? avatar,
    String? bio,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? dob,
    int? age,
    String? ridingExperience,
    String? gender,
    String? bloodGroup,
    String? mobile,
    String? address,
    String? city,
    String? state,
    String? country,
    String? zip,
    String? firstname,
    String? lastname,
    String? email,
    String? alias,
    String? website,
    String? latLng,
    String? currency,
    String? nextOfKin,
    int? nextOfKinMobile,
    bool? currentlyLoggedIn,
  }) {
    return AppUser(
      id: id ?? this.id,
      user: user ?? this.user,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dob: dob ?? this.dob,
      age: age ?? this.age,
      ridingExperience: ridingExperience ?? this.ridingExperience,
      gender: gender ?? this.gender,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zip: zip ?? this.zip,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      alias: alias ?? this.alias,
      website: website ?? this.website,
      latLng: latLng ?? this.latLng,
      currency: currency ?? this.currency,
      nextOfKin: nextOfKin ?? this.nextOfKin,
      nextOfKinMobile: nextOfKinMobile ?? this.nextOfKinMobile,
      currentlyLoggedIn: currentlyLoggedIn ?? this.currentlyLoggedIn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user,
      'avatar': avatar,
      'bio': bio,
      'update_at': updatedAt?.toIso8601String(),
      'DOB': dob?.toIso8601String(),
      'age': age,
      'riding_experience': ridingExperience,
      'gender': gender,
      'blood_group': bloodGroup,
      'mobile': mobile,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'zip': zip,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'alias': alias,
      'website': website,
      'latlng': latLng,
      'currency': currency,
      'nextofkin': nextOfKin,
      'nextofkinmobile': nextOfKinMobile,
      'currently_logged_in': currentlyLoggedIn,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] != null ? map['id'] as String : null,
      user: map['user'] != null ? map['user'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      dob: map['DOB'] != null ? DateTime.parse(map['DOB'] as String) : null,
      age: map['age'] != null ? map['age'] as int : null,
      ridingExperience: map['riding_experience'] != null
          ? map['riding_experience'] as String
          : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      bloodGroup:
          map['blood_group'] != null ? map['blood_group'] as String : null,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      zip: map['zip'] != null ? map['zip'] as String : null,
      firstname: map['firstname'] != null ? map['firstname'] as String : null,
      lastname: map['lastname'] != null ? map['lastname'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      alias: map['alias'] != null ? map['alias'] as String : null,
      website: map['website'] != null ? map['website'] as String : null,
      latLng: map['latlng'] != null ? map['latlng'] as String : null,
      currency: map['currency'] != null ? map['currency'] as String : null,
      nextOfKin: map['nextofkin'] != null ? map['nextofkin'] as String : null,
      nextOfKinMobile:
          map['nextofkinmobile'] != null ? map['nextofkinmobile'] as int : null,
      currentlyLoggedIn: map['currently_logged_in'] != null
          ? map['currently_logged_in'] as bool
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  static List<AppUser>? fromJsonList(List<dynamic>? jsonList) {
    return jsonList?.map((e) => AppUser.fromMap(e)).toList();
  }
}
