import 'dart:math';
import 'user.dart';
/// this function craves for implementation...
Future<bool> dataIsCorrect(String nick, String pass) async{
  if (nick.length > 0 && nick[0] == 'a' && pass.length > 0) return true;
  return false;

}

/// this function craves for implementation...
Future<Map<String, dynamic>> getDataByNick(String nick) async{
  return {};
}
/// this function craves for implementation...
Map<String, dynamic> getEmptyMap(){
  return {'used_id': 'A', 'allias':'FG', 'name':'G', 'surname':'F', 'e-mail':'F',
    'phone_number':'F', 'telegram':'F', 'profile_image':'a', 'password_hash':'a',
    'token':'A', 'rating':'A'};
}

/// this function craves for implementation...

Future<int> getHash(String pass) async{
    return 42;
}

/// this function craves for implementation...
Future<bool> nickExists(String candidate) async{
  if (candidate.length > 0 && candidate[0] == 'a') return true;
  return false;
}

/// this function craves for implementation...
Future<void> addUser(User user) async{

}

Future<int> getId(String name) async{
  return 0;
}