import 'package:http/http.dart';
import 'package:mmdapp/services/urlconstants.dart' as UrlConsts;
import 'package:mmdapp/utils/api_utils.dart';

Future<Map<String, dynamic>> getDoctor(num doctor_id) async {
  try {
    Response data = await getApi("/api/common_m/${doctor_id}/get-doctor/", {});
    Map<String, dynamic> body = decodeBody(data.body);

    if (body.containsKey("success")) {
      return {
        'success': body["success"],
        'message': body["msg"],
        'data': body['data']
      };
    } else {
      return {'success': false, 'message': "Something Went Wrong"};
    }
  } catch (e) {
    return {'success': false, 'message': "Something Went Wrong"};
  }
}

Future<List<dynamic>> getDoctors(String doctor_tag) async {
  try {
    Response data =
        await getApi(UrlConsts.GET_DOCTORS + "?category=" + doctor_tag, {});
    List<dynamic> body = decodeBody(data.body);
    return body;
  } catch (e) {
    return [];
  }
}

//get profile data
Future<Map<String, dynamic>> getProfileData() async {
  try {
    Response data = await getApi("/api/userpanel/get-profile", {});
    Map<String, dynamic> body = decodeBody(data.body);

    if (body.containsKey("success")) {
      return {
        'success': body["success"],
        'message': body["msg"],
        'data': body['data']
      };
    } else {
      return {'success': false, 'message': 'Something Went Wrong'};
    }
  } catch (e) {
    return {'success': false, 'message': "Something Went Wrong"};
  }
}

//update profile data
Future<Map<String, dynamic>> updateProfileData(Map profileData) async {
  try {
    Response data =
        await postApi("/api/userpanel/update-profile/", profileData, {});
    Map<String, dynamic> body = decodeBody(data.body);

    if (body.containsKey("success")) {
      return {
        'success': body["success"],
        'message': body["msg"],
        'data': body['data']
      };
    } else {
      return {'success': false, 'message': 'Something Went Wrong'};
    }
  } catch (e) {
    print(e);
    return {'success': false, 'message': "Something Went Wrong"};
  }
}
