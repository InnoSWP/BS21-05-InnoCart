import 'dart:convert';
import 'dart:math';
import 'user.dart';
import 'package:http/http.dart' as http;


const String serverURL = "127.0.0.1:8000";
User currentUser = User(getEmptyMap());


//test
/// this function craves for implementation...
Future<bool> dataIsCorrect(String nick, String pass) async {
  if (nick.length > 0 && nick[0] == 'a' && pass.length > 0) return true;
  return false;
}

/// this function craves for implementation...
Future<Map<String, dynamic>> getDataByNick(String nick) async {
  return {};
}

/// this function craves for implementation...
Map<String, dynamic> getEmptyMap() {
  return {
    'used_id': 0,
    'allias': '',
    'name': '',
    'surname': '',
    'e-mail': '',
    'phone_number': '',
    'telegram': '',
    'profile_image': '',
    'password_hash': '',
    'token': '',
    'rating': ''
  };
}

/// this function craves for implementation...

Future<int> getHash(String pass) async {
  return pass.hashCode;
}

/// this function craves for implementation...
Future<bool> nickExists(String candidate) async {
  try {
    final http.Response response = await http.get(
        Uri.parse('${serverURL}nickExists?user_nickname=${candidate}')
    );
    print("GOT DATA FROM API");
    print(response.body.replaceAll("'", "\""));
    Map<String, dynamic> data = jsonDecode(response.body.replaceAll("'", "\""));
    print('data fetched from API');
    print(data);
    if (data['exists'] == 0) {
      return false;
    }
  }
  on Exception catch (_, e){
    print(e.toString());
  }
  return true;
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
    print("Send a request");
    Uri request = Uri.http(serverURL, '/contactDataOccupied', queryParameters);
    print(request);
    final http.Response response = await http.get(request);
    print(response.body);
    if (response.statusCode == 200){
      return jsonDecode(response.body.replaceAll("'", "\""))['occupied'] == 1;
    }
    else{
      print(response.body);
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
    Map<String, dynamic> registerRequestData = {
      "nickname": user.nickname,
      "name": user.name,
      "surname": user.surname,
      "email": user.email,
      "phone_number": user.phoneNumber,
      "telegram": user.telegram,
      "password_hash": user.passwordHash
    };
    Uri uri = Uri.http(serverURL, '/register');
    http.Response response = await http.post(uri, body: registerRequestData);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      currentUser.userId = responseBody['user_id'];
      currentUser.token = responseBody['token'];
      currentUser.rating = responseBody['rating'];
      currentUser.ticketsAmount = responseBody['tickets_amount'];
      return true;
    }
  }
  on Exception catch(_, e){
  }
  return false;
}
Future<int> getId(String name) async {
  return 0;
}
