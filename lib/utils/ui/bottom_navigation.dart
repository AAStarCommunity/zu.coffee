import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';


class BottomNavigation extends StatefulWidget {

  ValueChanged<int>? onIndexChanged;

  BottomNavigation({super.key, this.onIndexChanged});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();

}

class _BottomNavigationState extends State<BottomNavigation> {

  int index=0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        showSelectedLabels: false,
        currentIndex: index,
        onTap: (value) {
          index = value;
          widget.onIndexChanged?.call(value);
          setState(() {});
        },
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.surface,
        items: [
          BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                Icons.home,
                color: index == 0 ? AppColors.caramelBrown : Colors.grey.withOpacity(.6),
              )),
          BottomNavigationBarItem(
              label: "Shop",
              icon: Icon(
                Icons.shopify,
                color: index == 1 ? AppColors.caramelBrown : Colors.grey.withOpacity(.6),
              )),
          BottomNavigationBarItem(
              label: "Transaction",
              icon: Icon(
                Icons.list,
                color: index==2?Colors.orange:Colors.grey.withOpacity(.6),
              )),
          // BottomNavigationBarItem(
          //     label: "Favourite",
          //     icon: Icon(
          //       Icons.notification_add,
          //       color: index==3?Colors.orange:Colors.grey.withOpacity(.6),
          //     )),
        ]);
  }
}
