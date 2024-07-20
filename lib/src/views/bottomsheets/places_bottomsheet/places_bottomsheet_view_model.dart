import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/src/models/ors_models/get_geocode_response_model.dart';
import 'package:starter_app/src/services/remote/base/ors_service_view_model.dart';

class PlacesBottomSheetViewModel extends ReactiveViewModel
    with OrsServiceViewModel {
  List<Features> places = [];

  void init() {}

  final TextEditingController searchController = TextEditingController();

  getAutoCompletePlaces() async {
    if (searchController.text.isEmpty) {
      return;
    }
    setBusy(true);

    final res = await orsService.searchAutocomplete(searchController.text);

    if (res == null) {
      setBusy(false);
      return;
    }

    res.when(
      success: (data) {
        places = data.features ?? [];
        setBusy(false);
      },
      failure: (error) {
        setBusy(false);
      },
    );
  }

  getSearchPlaces() async {
    if (searchController.text.isEmpty) {
      return;
    }
    setBusy(true);

    final res = await orsService.search(searchController.text);

    if (res == null) {
      setBusy(false);
      return;
    }

    res.when(
      success: (data) {
        places = data.features ?? [];
        setBusy(false);
      },
      failure: (error) {
        setBusy(false);
      },
    );
  }

  onChanged() {
    Future.delayed(const Duration(milliseconds: 500), () {
      getAutoCompletePlaces();
    });
  }

  onDone() {
    getSearchPlaces();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
