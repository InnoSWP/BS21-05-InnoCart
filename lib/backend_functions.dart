import 'dart:convert';
import 'dart:math';
import 'user.dart';
import 'package:http/http.dart' as http;


const String serverURL = "127.0.0.1:8000";
User currentUser = User(getEmptyMap());


//test
/// this function craves for implementation...
Future<bool> dataIsCorrect(String nick, String pass) async {
  Map<String, dynamic> requestParameters = {
    "nickname": nick,
    "password_hash": getHash(pass)
  };
  Uri uri = Uri.http(serverURL, '/loginByNickname', requestParameters);
  print(uri);
  http.Response response = await http.get(uri);
 // print(response.body);
  if (response.statusCode == 200){
    Map<String, dynamic> userData = jsonDecode(
        response.body.replaceAll("'", "\"").replaceAll("None", '""'));
    for (var kek in userData.keys){
      if (userData[kek] == null){
        userData[kek] = 'a';
      }
    }
    print("NEW TOKEN AFTER AUTH = ${userData['token']}");
    currentUser = User(userData);
    return true;
  }
  return false;
}

/// this function craves for implementation...
Future<Map<String, dynamic>> getDataByNick(String nick) async {
  return {};
}

/// this function craves for implementation...
Map<String, dynamic> getEmptyMap() {
  return {
    'user_id': 0,
    'nickname': '',
    'name': '',
    'surname': '',
    'email': '',
    'phone_number': '',
    'telegram': '',
    'profile_image': '',
    'password_hash': '',
    'token': '',
    'rating': 0.0,
    'tickets_amount': 0
  };
}

/// this function craves for implementation...

String getHash(String pass){
  return pass.hashCode.toString();
}


Future<bool> contactDataOccupied(
    User userRegisterInformation
    ) async{
  try{
    final Map<String, String> queryParameters = {
      'user_nickname': userRegisterInformation.nickname,
      'user_phone_number': userRegisterInformation.phoneNumber,
      'user_telegram': userRegisterInformation.telegram,
      'user_email': userRegisterInformation.email
    };
    Uri request = Uri.http(serverURL, '/contactDataOccupied', queryParameters);
    //print(request);
    final http.Response response = await http.get(request);
    print(response.body);
    if (response.statusCode == 200){
      return jsonDecode(response.body.replaceAll("'", "\"")
          .replaceAll('None', ""))['occupied'] == 1;
    }

    else{
      //print(response.body);
    }
    return true;

  }
  on Exception catch(_, e){
    print(e.toString());
  }
  return true;
}

/// this function craves for implementation...
Future<bool> addUser(User user) async {
  try {
    Map<String, String> registerRequestData = {
      "nickname": user.nickname,
      "name": user.name,
      "surname": user.surname,
      "email": user.email,
      "phone_number": user.phoneNumber,
      "telegram": user.telegram,
      "password_hash": user.passwordHash
    };
    print("USER PASSWORD HASH IS = ${user.passwordHash}");
    print(registerRequestData);

    Uri uri = Uri.http(serverURL, '/register', registerRequestData);
    http.Response response = await http.post(uri);
    print("Got response from server");
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(
          response.body.replaceAll("'", '"').replaceAll("None", '\"\"'));
      currentUser.userId = responseBody['user_id'];
      currentUser.token = responseBody['token'];
      currentUser.rating = responseBody['rating'];
      currentUser.ticketsAmount = responseBody['tickets_amount'];
      return true;
    }
  }
  on Exception catch(_, e){
    print(e.toString());
  }
  return false;
}


Future<Map<String, dynamic>> registerNewTicket(Map<String,
    dynamic> requestData) async{
  print("And function registerNewTicket proceeded argument correctly");
  requestData['shopper_id'] = currentUser.userId.toString();
  requestData['shopper_token'] = currentUser.token;
  print('currentUserToken = ${currentUser.token}');
  print(requestData);
  Uri uri = Uri.http(serverURL, '/registerNewTicket', requestData);
  print("url of new ticket post request: $uri");
  http.Response response = await http.post(uri);
  print("status code of the response: ${response.statusCode}\n"
      "body of the response: ${response.body}");
  if (response.statusCode == 200){
    return jsonDecode(response.body.replaceAll("'",
        '"').replaceAll("None", "\"\""));
  }
  return {
    "status_code": 500
  };
}

Future<Map<String, dynamic>> getTicketHistory(
    int ticketStatus,
    int fromAngel
    ) async{
  Map<String, String> args = {
    "user_id": currentUser.userId.toString(),
    "user_token": currentUser.token,
    "ticket_states": ticketStatus.toString(),
    "from_angel": fromAngel.toString()
  };
  Uri uri = Uri.http(serverURL, '/getTicketHistory', args);
  print(uri);
  http.Response response = await http.get(uri);
  if (response.statusCode == 200){
    return jsonDecode(response.body);
  }
  return {};
}


Future<int> getId(String name) async {
  return 0;
}
