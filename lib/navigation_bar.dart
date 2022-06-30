import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'main.dart';

//
//
// Deprecated due to lint ERRORS
//
//
void pageUpdate(int index, BuildContext context) {
  if (selectedPage == index) return;
  selectedPage = index;

  switch (index) {
    case 0:
      Navigator.of(context).pushReplacementNamed('/PageOfActiveOrders');
      break;
    case 1:
      Navigator.of(context).pushReplacementNamed('/ShopperOrders');
      break;
    case 2:
      Navigator.of(context).pushReplacementNamed('/CreatingOrderScreen');
      break;
    case 3:
      Navigator.of(context).pushReplacementNamed('/Messenger');
      break;
    case 4:
      Navigator.of(context).pushReplacementNamed('/ProfileScreen');
      break;
    default:
      Navigator.of(context).pushReplacementNamed('/');
  }
}
//
//
// Deprecated due to lint ERRORS
//
//

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({Key? key}) : super(key: key);
  @override
  State<MainNavigationBar> createState() => MainNavigationBarState();
}

class MainNavigationBarState extends State<MainNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      selectedIndex: selectedPage,
      onDestinationSelected: (index) {
        if (selectedPage != index) {
          setState(() {
            selectedPage = index;
          });
          pageUpdate(selectedPage);
        }
      },
      destinations: [
        NavigationDestination(
          icon: SvgPicture.asset('assets/icons/List Icon.svg',
              width: 24, height: 24),
          label: 'Orders',
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/icons/Arhive_light.svg',
            width: 22,
            height: 22,
          ),
          label: 'My Tickets',
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/icons/Create Order Button.svg',
            width: 120,
            height: 35,
          ),
          label: 'Create Order',
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/icons/Message Icon.svg',
            width: 28,
            height: 28,
            color: Colors.black,
          ),
          label: 'Messenger',
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/icons/User_alt_light.svg',
            width: 24,
            height: 24,
          ),
          label: 'Profile',
        ),
      ],
    );
  }

  void pageUpdate(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacementNamed('/PageOfActiveOrders');
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed('/ShopperOrders');
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed('/CreatingOrderScreen');
        break;
      case 3:
        Navigator.of(context).pushReplacementNamed('/Messenger');
        break;
      case 4:
        Navigator.of(context).pushReplacementNamed('/ProfileScreen');
        break;
      default:
        Navigator.of(context).pushReplacementNamed('/');
    }
  }
}
