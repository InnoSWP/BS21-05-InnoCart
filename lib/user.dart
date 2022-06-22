

class User{
  String nickname = "";
  String phoneNumber = "";
  String telegram = "";
  String email = "";
  String name = "";
  String surname = "";
  String passwordHash = "";
  String token = "";
  int userId = 0;
  double rating = 0;
  int ticketsAmount = 0;

  User(Map<String, dynamic> initialData){
    nickname = initialData['allias'];
    phoneNumber = initialData['phone_number'];
    telegram = initialData['telegram'];
    email = initialData['e-mail'];
    name = initialData['name'];
    surname = initialData['surname'];
    passwordHash = initialData['password_hash'];
    token = initialData['token'];
    userId = initialData['user_id'];
  }
}