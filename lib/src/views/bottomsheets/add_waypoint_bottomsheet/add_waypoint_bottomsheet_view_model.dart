import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/models/ors_models/get_geocode_response_model.dart';
import 'package:starter_app/src/services/remote/base/ors_service_view_model.dart';

class AddWaypointBottomSheetViewModel extends ReactiveViewModel
    with OrsServiceViewModel {
  List<Features> places = [];

  void init() {
    arivalTimeController.text = formatDate(arrivalTime);
  }

  TextEditingController descriptionController = TextEditingController();
  TextEditingController arivalTimeController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  double? destLat;
  double? destLong;

  DateTime arrivalTime = DateTime.now();

  onArrivalTimeChanged(DateTime? v) {
    // arrivalTime = DateTime.tryParse(v);
    if (v == null) {
      return;
    }
    arrivalTime = v;

    // arivalTimeController.text = DateFormat('yMMMd').format(v);
    notifyListeners();
  }

  onChangeDestination(Features? v) {
    if (v == null) return;
    destinationController.text = v.properties?.label ?? '';
    destLong = v.geometry?.coordinates?.first;
    destLat = v.geometry?.coordinates?.last;
    notifyListeners();
  }

  onChangeArrivalTime(DateTime? date) {
    if (date == null) return;
    arrivalTime = date;
    arivalTimeController.text = formatDate(date);
    notifyListeners();
  }

  String formatDate(DateTime time) {
    return DateFormat('yMMMd').format(time);
  }

  @override
  void dispose() {
    descriptionController.dispose();
    arivalTimeController.dispose();
    destinationController.dispose();

    super.dispose();
  }
}
