import 'dart:convert';
import 'package:aylin/core/resources/data_state.dart';
import 'package:aylin/services/http_service.dart';
import 'package:flutter/foundation.dart';

abstract class ForgotPasswordRepository {
  Future<DataState<bool>> sendCode({required String phoneNumber});
  Future<DataState<bool>> verifyPhoneCode({required String phoneNumber, required String code});
}

final class ForgotPasswordRepositoryImpl extends ForgotPasswordRepository {
  final HttpService _service = HttpService();

  @override
  Future<DataState<bool>> sendCode({required String phoneNumber}) async {
    try {
      final data = {
        "phone": phoneNumber,
      };
      final res = await _service.postData(data: data, apiUrl: "/sendCodeToPhone");
      final body = json.decode(res.body);

      if (body["success"] == true) {
        return const DataSuccess(true);
      } else {
        final errorMessage = body["error"] ?? "Doğrulama kodu gönderilemedi";
        return DataFailed(FlutterError(errorMessage));
      }
    } catch (error) {
      return DataFailed(FlutterError("Doğrulama kodu gönderilemedi"));
    }
  }

  @override
  Future<DataState<bool>> verifyPhoneCode({required String phoneNumber, required String code}) async {
    try {
      final data = {
        "phone": phoneNumber,
        "code": code,
      };
      final res = await _service.postData(data: data, apiUrl: "/verifyPhoneCode");
      final body = json.decode(res.body);

      if (body["success"] == true) {
        return const DataSuccess(true);
      } else {
        final errorMessage = body["error"] ?? "Doğrulama kodu başarısız";
        return DataFailed(FlutterError(errorMessage));
      }
    } catch (error) {
      return DataFailed(FlutterError("Doğrulama kodu başarısız"));
    }
  }
}
