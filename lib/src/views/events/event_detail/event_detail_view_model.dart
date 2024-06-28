import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/models/event.dart';
import 'package:starter_app/src/models/ors_models/get_geocode_response_model.dart';
import 'package:starter_app/src/models/waypoint.dart';
import 'package:starter_app/src/services/local/base/data_view_model.dart';
import 'package:starter_app/src/services/remote/base/database_view_model.dart';
import 'package:starter_app/src/services/remote/base/ors_service_view_model.dart';
import 'package:starter_app/src/services/remote/base/supabase_auth_view_model.dart';
import 'package:starter_app/src/styles/app_colors.dart';

class EventDetailViewModel extends ReactiveViewModel
    with
        SupabaseAuthViewModel,
        DatabaseViewModel,
        DataViewModel,
        OrsServiceViewModel {
  late final Event event;
  late LatLng destination;

  // double? waypointLat;
  // double? waypointLong;

  // String? waypointLabel;
  ValueNotifier<Features?> selectedPlace = ValueNotifier(null);

  List<Waypoint> waypoints = [];

  List<Marker> markers = [];

  final MapController mapController = MapController();

  init(Event e) {
    event = e;
    destination = LatLng(event.destLat ?? 0, event.destLong ?? 0);
    markers.add(
      Marker(
        width: 30.0,
        height: 30.0,
        point: destination,
        builder: (context) => SvgPicture.asset(AssetIcons.locationMarker),
      ),
    );
    // markers.add(
    //   Marker(
    //     width: 20.0,
    //     height: 20.0,
    //     point: LatLng(31.873883, 70.701903),
    //     builder: (context) => SvgPicture.asset(
    //       AssetIcons.locationIcon,
    //       color: AppColors.red,
    //     ),
    //   ),
    // );

    getAllWayPoints();
    notifyListeners();
  }

  onTapMap(LatLng latLng) {
    print(latLng.latitude);
    print(latLng.longitude);

    getPlace(latLng);
  }

  Future<bool> addWaypoint(Waypoint point) async {
    if (selectedPlace.value == null) {
      return false;
    }
    setBusy(true);
    final res = await databaseService.insertWaypoint(
      // Waypoint(
      //   addedBy: supabaseAuthService.user,
      //   noOfDays: 1,
      //   startTime: DateTime.now(),
      //   endTime: DateTime.now().add(const Duration(days: 1)),
      //   event: event.id,
      //   lat: selectedPlace.value?.geometry?.coordinates?.last ?? 0,
      //   long: selectedPlace.value?.geometry?.coordinates?.first ?? 0,
      //   label: selectedPlace.value?.properties?.label ?? '',
      // ),
      point,
    );

    if (res == null) {
      setBusy(false);
      return false;
    }

    markers.add(
      Marker(
        width: 20.0,
        height: 20.0,
        point: LatLng(res.lat ?? 0, res.long ?? 0),
        builder: (context) => SvgPicture.asset(
          AssetIcons.locationIcon,
          color: AppColors.red,
        ),
      ),
    );
    waypoints.add(res);
    notifyListeners();
    setBusy(false);
    return true;
  }

  ValueNotifier<bool> placeLoading = ValueNotifier(false);

  setPlaceLoading(bool v) {
    placeLoading.value = v;
    notifyListeners();
  }

  getPlace(LatLng latLng) async {
    setPlaceLoading(true);
    final res =
        await orsService.reverse(lat: latLng.latitude, lon: latLng.longitude);

    if (res == null) {
      setPlaceLoading(false);
      return;
    }

    res.when(
      success: (value) {
        setPlaceLoading(false);
        selectedPlace.value = value.features?.first;
        notifyListeners();
      },
      failure: (error) {
        print(error);
        setPlaceLoading(false);
        print(error);
      },
    );
  }

  clearFields() {
    selectedPlace.value = null;
    notifyListeners();
  }

  getAllWayPoints() async {
    waypoints = await databaseService.getAllWaypoints(event.id!) ?? [];
    if (waypoints.isNotEmpty) {
      waypoints.forEach((element) {
        print('label in foreach is ${element.label}');
        markers.add(Marker(
          width: 20.0,
          height: 20.0,
          point: LatLng(element.lat ?? 0, element.long ?? 0),
          builder: (context) => SvgPicture.asset(
            AssetIcons.locationIcon,
            color: AppColors.red,
          ),
        ));

        notifyListeners();
      });
      waypoints.sort(
        (a, b) => a.startTime!.compareTo(b.startTime!),
      );
    }
    notifyListeners();
  }

  int selectedBottomNavIndex = 0;

  onChangeBottomNavIndex(int index) {
    selectedBottomNavIndex = index;
    notifyListeners();
  }

  // TextEditingController descriptionController = TextEditingController();
  // TextEditingController arivalTimeController = TextEditingController();
  // TextEditingController destinationController = TextEditingController();

  // double? destLat;
  // double? destLong;

  // DateTime? arrivalTime;

  // onArrivalTimeChanged(DateTime? v) {
  //   // arrivalTime = DateTime.tryParse(v);
  //   if (v == null) {
  //     return;
  //   }
  //   arrivalTime = v;

  //   // arivalTimeController.text = DateFormat('yMMMd').format(v);
  //   notifyListeners();
  // }

  // onChangeDestination(Features? v) {
  //   if (v == null) return;
  //   destinationController.text = v.properties?.label ?? '';
  //   destLong = v.geometry?.coordinates?.first;
  //   destLat = v.geometry?.coordinates?.last;
  //   notifyListeners();
  // }
}
