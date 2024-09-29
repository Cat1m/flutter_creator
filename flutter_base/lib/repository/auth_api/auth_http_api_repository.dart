import 'package:sample_flutter/model/user/user_model.dart';
import 'package:sample_flutter/repository/auth_api/auth_api_repository.dart';

import '../../data/network/network.dart';
import '../../utils/extensions/app_url.dart';

class AuthHttpApiRepository implements AuthApiRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  @override
  Future<UserModel> loginApi(dynamic data) async {
    dynamic response = await _apiServices.postApi(AppUrl.loginEndPint, data);
    return UserModel.fromJson(response);
  }
}
