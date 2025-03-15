import 'dart:convert';
import 'package:aylin/common/controller/user_controller.dart';
import 'package:aylin/common/model/user_model.dart';
import 'package:aylin/core/resources/data_state.dart';
import 'package:aylin/services/http_service.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginRepository {
  /* Future<bool> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    return true; 
  } */

  Future<DataState<String>> loginUser(
      {required String email, required String password});
  Future<DataState<bool>> getUserInfo({required String token});
}

final class LoginRepositoryImpl extends LoginRepository {
  final HttpService _service = HttpService();

  @override
  Future<DataState<String>> loginUser(
      {required String email, required String password}) async {
    try {
      final data = {"email": email, "password": password};
      final res = await _service.postData(data: data, apiUrl: "/login");
      final body = json.decode(res.body);
      if (body["success"] == "true") {
        return DataSuccess(body["token"]);
      }
      return DataFailed(FlutterError("Giriş bilgilerini kontrol ediniz"));
    } catch (error) {
      return DataFailed(FlutterError("Giriş bilgilerinizi kontrol ediniz"));
    }
  }

  @override
  Future<DataState<bool>> getUserInfo({required String token}) async{
    try{
      final res = await _service.getData(apiUrl:"/getUserInfo");
      final body =json.decode(res.body);
      if(body["success"]=="true"){
        final UserModel model =UserModel.fromJson(body["data"]);
        UserController.setUserInfo(model);
        return const DataSuccess(true);
      }
      return DataFailed(FlutterError(""));
    }catch(error){
      return DataFailed(FlutterError(""));
    }
  }
}
