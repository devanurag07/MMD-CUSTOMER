import 'dart:convert';
import 'package:http/http.dart';
import 'package:mmdapp/utils/api_utils.dart';
import 'package:mmdapp/services/urlconstants.dart' as UrlConsts;

Future<Map<String, dynamic>> loginSendOtp(int mobile) async {
  try {
    Response data =
        await postApi(UrlConsts.SEND_OTP, {'mobile': mobile.toString()}, {});
    Map<String, dynamic> body = decodeBody(data.body);

    print("hey");
    if (body.containsKey("success")) {
      return {'success': body["success"], 'message': body["msg"]};
    } else {
      return {'success': body["success"], 'message': body["msg"]};
    }
  } catch (e) {
    return {'success': false, 'message': "Something Went Wrong"};
  }
}

Future<Map<String, dynamic>> verifyOtp(int mobile, int otp) async {
  try {
    Response data = await postApi(UrlConsts.VERIFY_OTP,
        {"mobile": mobile.toString(), "otp": otp.toString()}, {});
    Map<String, dynamic> body = decodeBody(data.body);

    if (body.containsKey("success")) {
      return {
        'success': body["success"],
        'message': body["msg"],
        "response": body['response']
      };
    } else {
      return {'success': body["success"], 'message': body["msg"]};
    }
  } catch (e) {
    return {'success': false, 'message': "Something Went Wrong"};
  }
}
