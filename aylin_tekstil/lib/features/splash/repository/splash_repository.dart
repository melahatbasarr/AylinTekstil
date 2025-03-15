import 'dart:convert';
import 'package:aylin/common/controller/user_controller.dart';
import 'package:aylin/common/model/user_model.dart';
import 'package:aylin/services/http_service.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/resources/data_state.dart';

abstract class SplashRepository {
  Future<DataState<bool>> getUserInfo();
}

final class SplashRepositoryImpl extends SplashRepository {
  final HttpService _service = HttpService();

  @override
  Future<DataState<bool>> getUserInfo() async {
    try {
      final res = await _service.getData(apiUrl: "/getUserInfo");
      final body = json.decode(res.body);
      if(body["success"]=="true"){
        final UserModel model = UserModel.fromJson(body["data"]);
        UserController.setUserInfo(model);
        return const DataSuccess(true);
      }
      return DataFailed(FlutterError(""));
    } catch (error) {
      return DataFailed(FlutterError(""));
    }
  }

}