import 'package:dio/dio.dart';
import 'package:starter_app/src/base/utils/constants.dart';
import 'package:starter_app/src/services/remote/api_result.dart';
import 'package:starter_app/src/services/remote/network_exceptions.dart';
import 'package:starter_app/src/services/remote/ors/ors_api_client.dart';

class OrsService {
  OrsApiClient? _apiClient;

  OrsService() {
    _apiClient = OrsApiClient(Dio());
  }

  Future<ApiResult<dynamic>?> searchAutocomplete(String searchQuery) async {
    try {
      var response = await _apiClient?.getReq(
        "/geocode/autocomplete",
        queryParameters: {"text": searchQuery},
      );
      print('res of search $response');
      if (response!.statusCode != 200) {
        Constants.customWarningSnack(response.statusMessage.toString());
        return null;
      }
      print('res data of search ${response.data}');
      return ApiResult.success(data: response.data);
    } catch (e) {
      Constants.customWarningSnack(
          NetworkExceptions.getDioExceptionMessage(e).toString());
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }
}
