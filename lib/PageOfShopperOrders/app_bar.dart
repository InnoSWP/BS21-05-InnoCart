import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
class ThisAppBar extends StatelessWidget implements PreferredSizeWidget {
  GlobalKey<FlipCardState> cardKey;
  ThisAppBar(this.cardKey,{Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Center ( child: ElevatedButton(
        onPressed: () {
          cardKey.currentState?.toggleCard();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.yellowAccent,
        ),
        child: SizedBox(
          width: 270,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text('Move to Angel page',
                  style: TextStyle(color: Colors.black, fontSize: 16)),
              Padding(
                padding: EdgeInsets.only(left: 45),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),),
    );
  }
}
