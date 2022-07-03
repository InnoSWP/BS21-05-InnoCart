class Ticket {
  late final int ticketId;
  late final int shopperId;
  late int angelId = -1;
  late final String title;
  late final String description;
  late final double weight;
  final String distance = '124 m';
  String ticketImage =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGrvu5dvNWm3aeTwcEfGy5uW2nTSI6dMU-ENCRvcL7UGS7sEYfNTvhFx6_gnajDWE8uLQ&usqp=CAU';
  final String type = 'Food';
  late final String reward;
  final String deadlineUnixTime = '14:00';
  final String creationUnixTime = '14:00';
  final String deadlineDate = '23.03.2022';
  late final TicketType status;
  late final TickerUser shopper;
  late final TickerUser angel;

  Ticket(Map<String, dynamic> data, url) {
    ticketId = data['ticket_id'];
    shopperId = data['shopper_id'];
    title = data['title'];
    description = data['description'];
    weight = data['weight'];
    reward = data['reward'].toString();

    ticketImage = url;

    if (data['status'] == 0) {
      status = TicketType.waitingForAccept;
    } else if (data['status'] == 1) {
      status = TicketType.inProgress;
    } else if (data['status'] == 2) {
      status = TicketType.completed;
    }
    print(data);

    shopper = TickerUser(
      data['shopper_id'],
      data['shopper_info']['nickname'],
      data['shopper_info']['name'],
      data['shopper_info']['surname'],
      data['shopper_info']['email'],
      data['shopper_info']['phone_number'],
      data['shopper_info']['telegram'],
      //data['shopper_info']['profile_image'],
      data['shopper_info']['rating'],
    );
    print("shopper is fine");
    print(data);
    if (status != TicketType.waitingForAccept) {
      angel = TickerUser(
        data['angel_id'],
        data['angel_info']['nickname'],
        data['angel_info']['name'],
        data['angel_info']['surname'],
        data['angel_info']['email'],
        data['angel_info']['phone_number'],
        data['angel_info']['telegram'],
        //data['angel_info']['profile_image'],
        data['angel_info']['rating'],
      );
      print("angel has been initialized");
    } else {
      angel = TickerUser(0, '', '', '', '', '', '', 0.0);
    }
  }
}

enum TicketType {
  waitingForAccept,
  inProgress,
  completed,
}

class TickerUser {
  final int id;
  final String nickname;
  final String name;
  String surname;
  String email = '';
  String phoneNumber = '';
  String telegram = '';
  String profileImage = 'assets/images/man1.png';
  final double rating;
  TickerUser(this.id, this.nickname, this.name, this.surname, this.email,
      this.phoneNumber, this.telegram, this.rating);
}

enum UserType {
  angel,
  shopper,
}
