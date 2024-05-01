import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/base/utils/local_db_keys.dart';
import 'package:starter_app/src/base/utils/supabase_buckets.dart';
import 'package:starter_app/src/base/utils/supabase_tables.dart';
import 'package:starter_app/src/configs/app_setup.locator.dart';
import 'package:starter_app/src/models/app_user.dart';
import 'package:starter_app/src/services/local/connectivity_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService with ListenableServiceMixin {
  static late final SharedPreferences prefs;

  static final ConnectivityService _connectivityService =
      locator<ConnectivityService>();

  static final _supabase = Supabase.instance.client;

  ReactiveValue<bool> _userLoggedIn =
      ReactiveValue(_supabase.auth.currentSession != null);

  bool get userLoggedIn => _userLoggedIn.value;

  ReactiveValue<AppUser?> _appUser = ReactiveValue<AppUser?>(null);

  AppUser? get user => _appUser.value;

  SupabaseAuthService() {
    listenToReactiveValues([_appUser, _userLoggedIn]);
    _syncUser();
    _restoreUserFromLocal();
    _setupAuthListner();
  }

  _setupAuthListner() {
    _supabase.auth.onAuthStateChange.listen(
      (data) {
        _userLoggedIn.value = data.session != null;
      },
    );
  }

  Future<AppUser?> register(
    String email,
    String password, {
    required String firstName,
    String? lastName,
    required String phone,
  }) async {
    if (!_connectivityService.isInternetConnected) {
      throw CustomNoInternetException(message: 'No Internet Connection');
    }
    try {
      final response = await _supabase.auth.signUp(
        email: email,
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
    if (!_connectivityService.isInternetConnected) {
      throw CustomNoInternetException(message: 'No Internet Connection');
    }
    try {
      final response = await _supabase.auth.signInWithPassword(
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
    if (!_connectivityService.isInternetConnected) {
      throw CustomNoInternetException(message: 'No Internet Connection');
    }
    try {
      await _supabase.auth.signOut();
      _clearUserFromLocal();
    } catch (e) {
      throw AuthExcepection(message: e.toString());
    }
  }

  Future<AppUser?> _createUser(AppUser? user) async {
    try {
      print('create user called');

      print(user?.toMap());
      AppUser? response;
      if (user != null) {
        final createdUser = await _supabase
            .from(SupabaseTables.appUsers)
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
      final response = await _supabase
          .from(SupabaseTables.appUsers)
          .select('*')
          .eq('id', id)
          .single();
      print('user: $response');
      return AppUser.fromMap(response);
    } catch (e) {
      print(e);
      return null;
    }
  }

  _syncUser() async {
    if (!_connectivityService.isInternetConnected) {
      print('no internet');
    }
    if (_supabase.auth.currentSession == null) {
      print('supabase auth session is null');
      return;
    }

    final response = await _getUser(_supabase.auth.currentUser!.id);

    if (response != null) {
      _appUser.value = response;
      _storeLocally();
    }
  }

  //for profile picture
  Future<String?> uploadProfilePicture(File image) async {
    try {
      if (!_connectivityService.isInternetConnected) {
        throw CustomNoInternetException(message: 'No Internet Connection');
      }
      final now = DateTime.now();
      final fileName = '${user?.id}/${now.millisecondsSinceEpoch}';
      final response =
          await _supabase.storage.from(SupabaseBuckets.profilePicBucket).upload(
                fileName,
                image,
              );

      final res = await _supabase.storage
          .from(SupabaseBuckets.profilePicBucket)
          .getPublicUrl(fileName);

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

  //Update user profile with avatar URL
  Future<AppUser?> _updateUserAvatar(String avatarUrl) async {
    if (!_connectivityService.isInternetConnected) {
      throw CustomNoInternetException(message: 'No Internet Connection');
    }

    try {
      final updatedUser = await _supabase
          .from(SupabaseTables.appUsers)
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
    print(_connectivityService.isInternetConnected);
    if (!_connectivityService.isInternetConnected) {
      throw CustomNoInternetException(message: 'No Internet Connection');
    }
    try {
      final response = await _supabase
          .from(SupabaseTables.appUsers)
          .update(user.toMap())
          .eq('id', user.id!)
          .select()
          .single();
      _appUser.value = AppUser.fromMap(response);
      _storeLocally();
      return AppUser.fromMap(response);
    } on PostgrestException catch (e) {
      //TODO: find a better way to do it.
      print(e);
      if (e.code == '23505' && e.message!.contains('Profile_alias_a_key')) {
        throw AuthExcepection(
          message: 'This alias is already taken, please choose another one',
        );
      }
      throw AuthExcepection(
        message: e.message.toString(),
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  //FOR LOCAL DB
  _storeLocally() async {
    if (_appUser.value == null) return;
    prefs.setString(
        LocalDatabaseKeys.appUser, _appUser.value?.toJson() ?? "{}");
  }

  _restoreUserFromLocal() async {
    if (!prefs.containsKey(LocalDatabaseKeys.appUser)) return;

    final savedUser = prefs.getString(LocalDatabaseKeys.appUser) ?? "{}";

    if (savedUser == "{}") {
      _appUser.value = null;
      return;
    }

    _appUser.value = AppUser.fromMap(
        jsonDecode(prefs.getString(LocalDatabaseKeys.appUser) ?? "{}")
            as Map<String, dynamic>);
  }

  _clearUserFromLocal() async {
    if (!prefs.containsKey(LocalDatabaseKeys.appUser)) return;
    prefs.remove(LocalDatabaseKeys.appUser);
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
