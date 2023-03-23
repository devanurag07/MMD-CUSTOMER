import 'package:http/http.dart';
import 'package:mmdapp/services/urlconstants.dart' as UrlConsts;
import 'package:mmdapp/utils/api_utils.dart';

Future<Map<String, dynamic>> getDoctors(num doctor_id) async {
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
      return {'success': body["success"], 'message': body["msg"]};
    }
  } catch (e) {
    return {'success': false, 'message': "Something Went Wrong"};
  }
}

// '/api/userpanel/timeslots-mobile/'

Future<Map<String, dynamic>> getTimeslots(num doctor_id) async {
  try {
    Response data =
        await getApi('/api/userpanel/${doctor_id}/timeslots-mobile', {});
    Map<String, dynamic> body = decodeBody(data.body);

    if (data.statusCode == 200) {
      return {'success': true, 'dates': body['dates']};
    } else {
      return {'success': false, 'message': "Something Went Wrong"};
    }
  } catch (e) {
    return {'success': false, 'message': "Something Went Wrong"};
  }
}

Future<Map<String, dynamic>> getDateTimeslots(
    num doctor_id, String date) async {
  try {
    Response data = await getApi(
        '/api/userpanel/${doctor_id}/timeslots-mobile?date=${date}', {});
    Map<String, dynamic> body = decodeBody(data.body);

    if (data.statusCode == 200) {
      return {'success': true, 'timeslots': body['timeslots']};
    } else {
      return {'success': false, 'message': "Something Went Wrong"};
    }
  } catch (e) {
    return {'success': false, 'message': "Something Went Wrong"};
  }
}

Future<Map<String, dynamic>> createAppointment(
    num doctorId, num timeslotId) async {
  print("hey create");
  try {
    Response data = await postApi('/api/userpanel/create_appointment/', {
      'doctor_id': doctorId.toString(),
      'timeslot_id': timeslotId.toString(),
    }, {});
    print(data);

    Map<String, dynamic> body = decodeBody(data.body);

    if (data.statusCode == 200) {
      return {'success': true, 'data': body['data']};
    } else {
      return {'success': false, 'message': "Something Went Wrong"};
    }
  } catch (e) {
    print('error');
    return {'success': false, 'message': "Something Went Wrong"};
  }
}

// Appointments
Future<Map> getAppointments() async {
  try {
    Response data = await getApi(UrlConsts.GET_APPOINTMENTS, {});
    var body = decodeBody(data.body);
    if (data.statusCode == 200) {
      return body;
    }

    return {
      "today_appointments": [],
      "past_appointments": [],
      "upcoming_appointments": []
    };
  } catch (e) {
    print(e);
    return {
      "today_appointments": [],
      "past_appointments": [],
      "upcoming_appointments": []
    };
  }
}

//List Prescriptions
Future<Map<String, dynamic>> listPrescriptions() async {
  try {
    Response data = await getApi('/api/prescription/', {});
    var body = decodeBody(data.body);
    if (data.statusCode == 200) {
      return {"success": true, 'data': body['records']};
    } else if (body.contains("msg")) {
      return {"success": false, 'message': body['msg']};
    }
    return {"success": false, 'message': 'Something Went Wrong'};
  } catch (e) {
    return {'success': false, 'message': "Something Went Wrong"};
  }
}
