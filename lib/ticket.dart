class Ticket {
  late int ticketId = 0;
  late int shopperId = 0;

  final String buttonText = 'Send request';
  final String profilePicture = 'assets/images/man1.png';
  final String orderImage = 'assets/images/pizza.jpg';
  late String orderName = "";
  late double orderWeight = 3.0;
  final String orderDistance = '124 m';
  late String orderTime = '14:00';
  late String orderDate = '03.06.2022';
  late String reward = '';
  late String orderInfo = 'I want two DoDo peperoni pizzas, thank you!';
  late String userName = "";
  late String userSurname = "";
  late String userNickname = "";
  late double userRating = 0;

  Ticket(Map<String, dynamic> data) {
    ticketId = data['ticket_id'];
    shopperId = data['shopper_id'];
    orderName = data['title'];
    orderWeight = data['weight'];
    userName = data['shopper_info']['name'];
    userSurname = data['shopper_info']['surname'];
    userNickname = data['shopper_info']['nickname'];
    userRating = data['shopper_info']['rating'];
    orderInfo = data['description'];
    reward = data['reward'].toString();
  }
}

enum TicketType {
  waitingForAccept,
  inProgress,
  completed,
}
