import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'ServerURL.dart';
import 'user.dart';
import 'package:http/http.dart' as http;

User currentUser = User(getEmptyMap());

//test
/// this function craves for implementation...
Future<bool> dataIsCorrect(String nick, String pass, [ok = 0]) async {
  Map<String, dynamic> requestParameters = {
    "nickname": nick,
    "password_hash": ok == 1 ? pass : getHash(pass)
  };
  print(requestParameters['password_hash']);
  Uri uri = Uri.http(serverURL, '/loginByNickname', requestParameters);
  if (kDebugMode) {
    print(uri);
  }
  http.Response response = await http.get(uri);
  // print(response.body);
  if (response.statusCode == 200) {
    Map<String, dynamic> userData = jsonDecode(
        response.body.replaceAll("'", "\"").replaceAll("None", '""'));
    for (var kek in userData.keys) {
      if (userData[kek] == null) {
        userData[kek] = 'a';
      }
    }
    if (kDebugMode) {
      print("NEW TOKEN AFTER AUTH = ${userData['token']}");
    }
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

String getHash(String pass) {
  return pass.hashCode.toString();
}

Future<bool> contactDataOccupied(User userRegisterInformation) async {
  try {
    final Map<String, String> queryParameters = {
      'user_nickname': userRegisterInformation.nickname,
      'user_phone_number': userRegisterInformation.phoneNumber,
      'user_telegram': userRegisterInformation.telegram,
      'user_email': userRegisterInformation.email
    };
    Uri request = Uri.http(serverURL, '/contactDataOccupied', queryParameters);
    //print(request);
    final http.Response response = await http.get(request);
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      return jsonDecode(response.body
              .replaceAll("'", "\"")
              .replaceAll('None', ""))['occupied'] ==
          1;
    } else {
      //print(response.body);
    }
    return true;
  } on Exception catch (_, e) {
    if (kDebugMode) {
      print(e.toString());
    }
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
    // print("USER PASSWORD HASH IS = ${user.passwordHash}");
    // print(registerRequestData);

    Uri uri = Uri.http(serverURL, '/register', registerRequestData);
    http.Response response = await http.post(uri);
    // print("Got response from server");
    // print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(
          response.body.replaceAll("'", '"').replaceAll("None", '""'));
      currentUser.userId = responseBody['user_id'];
      currentUser.token = responseBody['token'];
      currentUser.rating = responseBody['rating'];
      currentUser.ticketsAmount = responseBody['tickets_amount'];
      return true;
    }
  } on Exception catch (_, e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
  return false;
}

Future<Map<String, dynamic>> registerNewTicket(
    Map<String, dynamic> requestData) async {
  // print("And function registerNewTicket proceeded argument correctly");
  requestData['shopper_id'] = currentUser.userId.toString();
  requestData['shopper_token'] = currentUser.token;
  // print('currentUserToken = ${currentUser.token}');
  // print(requestData);
  Uri uri = Uri.http(serverURL, '/registerNewTicket', requestData);
  // print("url of new ticket post request: $uri");
  http.Response response = await http.post(uri);
  // print("status code of the response: ${response.statusCode}\n"
  //    "body of the response: ${response.body}");
  if (response.statusCode == 200) {
    return jsonDecode(
        response.body.replaceAll("'", '"').replaceAll("None", "\"\""));
  }
  return {"status_code": 500};
}

Future<Map<String, dynamic>> getTicketHistory(
    int ticketStatus, int fromAngel) async {
  Map<String, String> args = {
    "user_id": currentUser.userId.toString(),
    "user_token": currentUser.token,
    "ticket_states": ticketStatus.toString(),
    "from_angel": fromAngel.toString()
  };
  Uri uri = Uri.http(serverURL, '/getTicketHistory', args);
  // print(uri);
  http.Response response = await http.get(uri);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }
  return {};
}

// BOOK TICKET FUNCTION HAVE LOST ITS ACTUALITY
/*Future<bool> bookTicket(int ticketId) async{
  Map<String, String> args = {
    "ticket_id": ticketId.toString(),
    "angel_id": currentUser.userId.toString(),
    "angel_token": currentUser.token
  };
  Uri uri = Uri.http(serverURL, '/bookTicket', args);
  http.Response response = await http.post(uri);
  if (response.statusCode == 200){
    return true;
  }
  return false;
} */
// BOOK TICKET FUNCTION HAVE LOST ITS ACTUALITY

Future<bool> cancelBookOfTicket(int ticketId) async {
  Map<String, String> args = {
    "ticket_id": ticketId.toString(),
    "angel_id": currentUser.userId.toString(),
    "angel_token": currentUser.token
  };
  Uri uri = Uri.http(serverURL, '/cancelBookOfTicket', args);
  http.Response response = await http.post(uri);
  if (response.statusCode == 200) {
    return true;
  }
  // print(response.body);
  return false;
}

Future<bool> completeOrder(int ticketId) async {
  Map<String, String> args = {
    "ticket_id": ticketId.toString(),
    "shopper_id": currentUser.userId.toString(),
    "shopper_token": currentUser.token
  };
  Uri uri = Uri.http(serverURL, '/completeOrder', args);
  http.Response response = await http.post(uri);
  if (response.statusCode == 200) {
    return true;
  }
  // print(response.body);
  return false;
}

Future<int> getId(String name) async {
  return 0;
}

Future<bool> sendOfferToBookTicket(int ticketId) async {
  Map<String, String> requestArguments = {
    "angel_id": currentUser.userId.toString(),
    "angel_token": currentUser.token,
    "ticket_id": ticketId.toString()
  };
  Uri uri = Uri.http(serverURL, "/sendOfferToBookTicket", requestArguments);
  http.Response response = await http.post(uri);
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<Map<String, dynamic>> getOffersByTicketId(int ticketId) async {
  Map<String, String> requestArguments = {
    "ticket_id": ticketId.toString(),
    "shopper_id": currentUser.userId.toString(),
    "shopper_token": currentUser.token
  };
  Uri uri = Uri.http(serverURL, "/getOffersByTicketId", requestArguments);
  http.Response response = await http.get(uri);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }
  if (kDebugMode) {
    print(response.body);
  }
  return {"error": response.body};
}

Future<bool> acceptOffer(int offerId) async {
  Map<String, String> args = {
    "offer_id": offerId.toString(),
    "shopper_id": currentUser.userId.toString(),
    "shopper_token": currentUser.token
  };
  Uri requestUrl = Uri.http(serverURL, '/acceptOffer', args);
  http.Response response = await http.post(requestUrl);
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<Map<String, dynamic>> getOfferedTickets() async {
  Map<String, String> args = {
    "angel_id": currentUser.userId.toString(),
    "angel_token": currentUser.token
  };
  Uri uri = Uri.http(serverURL, "/getOfferedTickets", args);
  http.Response response = await http.get(uri);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }
  if (kDebugMode) {
    print(response.body);
  }
  return {};
}

Future<bool> cancelOffer(int ticketId) async {
  Map<String, String> args = {
    "angel_id": currentUser.userId.toString(),
    "angel_token": currentUser.token,
    "ticket_id": ticketId.toString()
  };
  Uri uri = Uri.http(serverURL, '/cancelOffer', args);
  http.Response response = await http.post(uri);
  if (response.statusCode == 200) {
    return true;
  }
  print(response.body);
  return false;
}

Future<bool> cancelOrder(int ticketId) async {
  Map<String, String> args = {
    'shopper_id': currentUser.userId.toString(),
    "shopper_token": currentUser.token,
    "ticket_id": ticketId.toString()
  };
  Uri uri = Uri.http(serverURL, '/cancelOrder', args);
  http.Response response = await http.post(uri);
  if (response.statusCode == 200) {
    return true;
  }
  if (kDebugMode) {
    print(response.body);
  }
  return false;
}

Future<Map<String, dynamic>> contactUserInformationById(int userId) async {
  Map<String, String> args = {'contact_user_id': userId.toString()};
  Uri uri = Uri.http(serverURL, '/userContactInformationById', args);
  http.Response response = await http.get(uri);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }
  print(response.body);
  return {};
}

Future<bool> updateContactInformation(String email, String telegram) async {
  Map<String, String> args = {
    "user_id": currentUser.userId.toString(),
    "user_token": currentUser.token,
    "email": email,
    "telegram": telegram
  };
  Uri uri = Uri.http(serverURL, '/updateContactInformation', args);
  http.Response response = await http.post(uri);
  if (response.statusCode == 200) {
    Map<String, dynamic> userData = jsonDecode(response.body);
    currentUser.email = userData['email'];
    currentUser.telegram = userData['telegram'];
    return true;
  }
  if (kDebugMode) print(response.body);
  return false;
}
