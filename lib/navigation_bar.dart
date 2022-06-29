import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'main.dart';

void pageUpdate(int index, BuildContext context) {
  {
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
}

NavigationBar makeNavigationBar(BuildContext context, var object) {
  NavigationBar navigationBar = NavigationBar(
    labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    selectedIndex: selectedPage,
    onDestinationSelected: (index) => pageUpdate(index, context),
    destinations: [
      NavigationDestination(
        icon: SvgPicture.asset('assets/icons/List Icon.svg',
            width: 24, height: 24),
        label: 'ListOfOrders',
      ),
      NavigationDestination(
        icon: SvgPicture.asset(
          'assets/icons/Arhive_light.svg',
          width: 19,
          height: 15,
        ),
        label: 'ListOfActiveOrders',
      ),
      NavigationDestination(
        icon: SvgPicture.asset(
          'assets/icons/Create Order Button.svg',
          width: 120,
          height: 35,
        ),
        label: 'CreateOrder',
      ),
      NavigationDestination(
        icon: SvgPicture.asset(
          'assets/icons/Message Icon.svg',
          width: 28,
          height: 28,
          color: Colors.black,
        ),
        label: 'ChatPage',
      ),
      NavigationDestination(
        icon: SvgPicture.asset(
          'assets/icons/User_alt_light.svg',
          width: 24,
          height: 24,
        ),
        label: 'ProfilePicture',
      ),
    ],
  );
  return navigationBar;
}
