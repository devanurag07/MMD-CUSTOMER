import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:http/http.dart' as http;
import 'package:mmdapp/screens/loginScreen.dart';
import 'package:mmdapp/utils/storage.dart';
import 'package:mmdapp/services/urlconstants.dart' as UrlConsts;

String base_url = "https://api.mymedbook.in";
// String base_url = "http://api.mymedbook.in";

Future<http.Response> getApi(String route, Map<String, String>? headers) async {
  var authToken = await getUserToken();
  headers?["Authorization"] = "JWT ${authToken}";
  var response = await http.get(Uri.parse(base_url + route), headers: headers);
  if (response.statusCode == 200 || response.statusCode == 201) {
    return response;
  } else {
    if (response.statusCode == 401) {
      var resp = jsonDecode(response.body);
      String? errorMsg = resp['detail'];
      if (errorMsg != null) {
        if (errorMsg.contains('expired')) {
          bool tokenUpdated = await tokenExpiredHandler();
          if (tokenUpdated == false) {
            await LocalStorage().clearAuthTokens();
            Get.to(LoginScreen());
            // Get.to('/login');
          } else {
            return await getApi(route, headers);
          }
        }
      }
    }

    return response;
  }
}

Future<http.Response> postApi(
    String route, Object? body, Map<String, String>? headers) async {
  var exceptUrls = [
    UrlConsts.VERIFY_OTP,
    UrlConsts.SEND_OTP,
    UrlConsts.REFRESH_TOKEN_API
  ];

  if (exceptUrls.contains(route)) {
    var response = await http.post(Uri.parse(base_url + route),
        body: body, headers: headers);
    return response;
  }

  var authToken = await getUserToken();
  headers?["Authorization"] = "JWT ${authToken}";

  var response = await http.post(Uri.parse(base_url + route),
      body: body, headers: headers);

  if (response.statusCode == 200 || response.statusCode == 201) {
    return response;
  } else {
    if (response.statusCode == 401) {
      var resp = jsonDecode(response.body);
      String? errorMsg = resp['detail'];
      if (errorMsg != null) {
        if (errorMsg.contains('expired')) {
          bool tokenUpdated = await tokenExpiredHandler();
          if (tokenUpdated == false) {
            await LocalStorage().clearAuthTokens();
            Get.to(LoginScreen());
            // Get.to('/login');
          } else {
            return await postApi(route, body, headers);
          }
        }
      }
    }
  }

  return response;
}

Future<bool> tokenExpiredHandler() async {
  var authToken = await getUserToken();
  var resp =
      await postApi(UrlConsts.REFRESH_TOKEN_API, {"token": authToken}, {});
  if (resp.statusCode == 200) {
    var data = jsonDecode(resp.body);
    if (data['token'] != null) {
      var token = data['token'];
      bool updated = await updateUserToken(token);

      if (updated) {
        return true;
      }
      return false;
    }
  }

  return false;
}

decodeBody(String body) {
  return jsonDecode(body);
}

Future<bool> isUserAuthenticated() async {
  try {
    Map userTokenData = await LocalStorage().getAuthTokens();
    print(userTokenData);
    print("token data");
    if (userTokenData.containsKey('user')) {
      return true;
    }
    return false;
  } catch (e) {
    print("error");
    print(e);
    return false;
  }
}

Future<String> getUserToken() async {
  try {
    Map userTokenData = await LocalStorage().getAuthTokens();
    if (userTokenData.containsKey('user')) {
      return userTokenData['user']['token'];
    }
    return '';
  } catch (e) {
    return '';
  }
}

Future<bool> updateUserToken(String token) async {
  try {
    Map userTokenData = await LocalStorage().getAuthTokens();
    if (userTokenData.containsKey('user')) {
      userTokenData['user']['token'] = token;
      LocalStorage().setAuthTokens(userTokenData);
    }
    return true;
  } catch (e) {
    return false;
  }
}
