import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/configs/app_setup.locator.dart';
import 'package:starter_app/src/models/app_user.dart';
import 'package:starter_app/src/services/local/connectivity_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService with ListenableServiceMixin {
  static late final SharedPreferences prefs;

  final String _prefKey = "app_user";

  static final ConnectivityService connectivityService =
      locator<ConnectivityService>();

  static final supabase = Supabase.instance.client;

  ReactiveValue<bool> _userLoggedIn =
      ReactiveValue(supabase.auth.currentSession != null);

  ReactiveValue<AppUser?> _appUser = ReactiveValue<AppUser?>(null);

  AppUser? get user => _appUser.value;

  bool get userLoggedIn => _userLoggedIn.value;

  SupabaseAuthService() {
    listenToReactiveValues([_appUser, _userLoggedIn]);
    syncUser();
    _restoreUserFromLocal();
    _setupAuthListner();
  }

  _setupAuthListner() {
    supabase.auth.onAuthStateChange.listen(
      (data) {
        _userLoggedIn.value = data.session != null;
      },
    );
  }

  Future<AppUser?> register(String email, String password,
      {required String firstName,
      String? lastName,
      required String phone}) async {
    if (!connectivityService.isInternetConnected) {
      throw CustomNoInternetException(message: 'No Internet Connection');
    }
    try {
      final response = await supabase.auth.signUp(
        email: email.trim(),
        password: password,
      );
      if (response.user == null) {
        throw AuthExcepection(message: 'Login Failed');
      }

      final AppUser user = AppUser(
        id: response.user?.id,
        email: response.user!.email,
        user: response.user?.id,
        firstname: firstName,
        lastname: lastName,
        mobile: phone,
      );
      final createdUser = await _createUser(user);

      if (createdUser == null) {
        throw AuthExcepection(message: 'Unable to create user');
      }

      _appUser.value = createdUser;
      _storeLocally();

      return createdUser;
    } catch (e) {
      throw AuthExcepection(message: e.toString());
    }
  }

  Future<AppUser?> login(String email, String password) async {
    if (!connectivityService.isInternetConnected) {
      throw CustomNoInternetException(message: 'No Internet Connection');
    }
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      if (response.user == null) {
        throw AuthExcepection(message: 'Login Failed');
      }

      final user = await _getUser(response.user!.id);

      if (user == null) {
        throw AuthExcepection(message: 'Unable to get user details');
      }

      _appUser.value = user;
      _storeLocally();
      return user;
    } catch (e) {
      throw AuthExcepection(message: e.toString());
    }
  }

  Future logout() async {
    await supabase.auth.signOut();
    _clearUserFromLocal();
  }

  Future<AppUser?> _createUser(AppUser? user) async {
    try {
      print('create user called');

      print(user?.toMap());
      AppUser? response;
      if (user != null) {
        final createdUser = await supabase
            .from('Profile')
            .insert(user.toMap())
            .select()
            .single();

        print('created user: $createdUser');
        response = AppUser.fromMap(createdUser);
      }

      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<AppUser?> _getUser(String id) async {
    try {
      final response =
          await supabase.from('Profile').select('*').eq('id', id).single();
      print('user: $response');
      return AppUser.fromMap(response);
    } catch (e) {
      print(e);
      return null;
    }
  }

  syncUser() async {
    if (!connectivityService.isInternetConnected) {
      print('no internet');
    }
    final response = await _getUser(supabase.auth.currentUser!.id);

    if (response != null) {
      _appUser.value = response;
      _storeLocally();
    }
  }

  //for profile picture

  // Add a method for uploading profile picture
  Future<String?> uploadProfilePicture(File image) async {
    try {
      if (!connectivityService.isInternetConnected) {
        throw CustomNoInternetException(message: 'No Internet Connection');
      }
      final now = DateTime.now();
      final fileName = '${user?.id}/${now.millisecondsSinceEpoch}';
      final response = await supabase.storage.from('Profilepic').upload(
            fileName,
            image,
          );

      final res =
          await supabase.storage.from('Profilepic').getPublicUrl(fileName);

      if (res != null) {
        final user = await _updateUserAvatar(res);
        if (user != null) {
          _appUser.value = user;
          _storeLocally();
          notifyListeners();
        }
      }

      return res;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// Update user profile with avatar URL
  Future<AppUser?> _updateUserAvatar(String avatarUrl) async {
    if (!connectivityService.isInternetConnected) {
      throw CustomNoInternetException(message: 'No Internet Connection');
    }

    try {
      final updatedUser = await supabase
          .from('Profile')
          .update({'avatar': avatarUrl})
          .eq('id', _appUser.value!.id!)
          .select()
          .single();

      _appUser.value = AppUser.fromMap(updatedUser);
      _storeLocally();

      return _appUser.value;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<AppUser?> updateUser(AppUser user) async {
    if (!connectivityService.isInternetConnected) {
      throw CustomNoInternetException(message: 'No Internet Connection');
    }
    try {
      final response = await supabase
          .from('Profile')
          .update(user.toMap())
          .eq('id', user.id!)
          .select()
          .single();
      // print('user: $response');
      _appUser.value = AppUser.fromMap(response);
      _storeLocally();
      return AppUser.fromMap(response);
    } catch (e) {
      print(e);
      return null;
    }
  }

  //for local db
  _storeLocally() async {
    if (_appUser.value == null) return;
    prefs.setString(_prefKey, _appUser.value?.toJson() ?? "{}");
  }

  _restoreUserFromLocal() async {
    if (!prefs.containsKey(_prefKey)) return;

    // print(prefs.getString(_prefKey));
    print(jsonDecode(prefs.getString(_prefKey) ?? "{}"));

    final savedUser = prefs.getString(_prefKey) ?? "{}";

    if (savedUser == "{}") {
      _appUser.value = null;
      return;
    }

    _appUser.value = AppUser.fromMap(
        jsonDecode(prefs.getString(_prefKey) ?? "{}") as Map<String, dynamic>);

    // _appUser.value = AppUser.fromJson(
    //     jsonDecode(prefs.getString(_prefKey) ?? "{}") as Map<String, dynamic>);
  }

  _clearUserFromLocal() async {
    if (!prefs.containsKey(_prefKey)) return;
    prefs.remove(_prefKey);
    _appUser.value = null;
  }
}

class AuthExcepection implements Exception {
  final String message;

  AuthExcepection({required this.message});
}

class CustomNoInternetException implements Exception {
  final String message;

  CustomNoInternetException({required this.message});
}
