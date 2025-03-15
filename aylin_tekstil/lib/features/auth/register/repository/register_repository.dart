import 'dart:convert';
import 'package:aylin/core/resources/data_state.dart';
import 'package:aylin/services/http_service.dart';
import 'package:flutter/foundation.dart';

abstract class RegisterRepository {
  Future<DataState<bool>> registerUser(
      {required String companyName,
      required String taxNumber,
      required String taxOffice,
      required String city,
      required String district,
      required String address,
      required String name,
      required String email,
      required String phone,
      required String password});
}

final class RegisterRepositoryImpl extends RegisterRepository {
  final HttpService _service = HttpService();

  @override
  Future<DataState<bool>> registerUser(
      {required String companyName,
      required String taxNumber,
      required String taxOffice,
      required String city,
      required String district,
      required String address,
      required String name,
      required String email,
      required String phone,
      required String password}) async {
    try {
      final data = {
        "title": companyName,
        "tax_no": taxNumber,
        "tax_name": taxOffice,
        "city_id": 61,
        "district_id": 901,
        "full_address": address,
        "name": name,
        "email": email,
        "phone": phone,
        "password": password
      };

      final res = await _service.postData(data: data, apiUrl: "/register");
      final body = json.decode(res.body);
      print("melo ben " +body);
      if (body["success"] == "true") {
        return const DataSuccess(true);
      }
      return DataFailed(FlutterError("Kayıt işlemi gerçekleştirilemedi"));
    } catch (error) {
      return DataFailed(FlutterError("Kayıt işlemi gerçekleştirilemedi"));
    }
  }
}
