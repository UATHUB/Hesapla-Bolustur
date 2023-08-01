import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_test1/controllers/first_half_controllers/page_controller.dart';

class SecondDrawer extends StatelessWidget {
  const SecondDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PageSelecter pc = Get.put(PageSelecter());
    return Drawer(
      width: 270,
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.secondaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .secondaryContainer
                      .withOpacity(0.75),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.money_sharp,
                  size: 48,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'BÖLÜŞTÜR!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.safety_divider_rounded,
              size: 30,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              "Hesapla! 'ya Geç",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 18,
                  ),
            ),
            onTap: () {
              pc.goToFirstPart();
            },
          ),
          const Spacer(),
          // ListTile(
          //   leading: Icon(
          //     Icons.auto_graph_outlined,
          //     size: 30,
          //     color: Theme.of(context).colorScheme.onBackground,
          //   ),
          //   title: Text(
          //     'Birikim Hedeflerini Yönet',
          //     style: Theme.of(context).textTheme.titleSmall!.copyWith(
          //           color: Theme.of(context).colorScheme.onBackground,
          //           fontSize: 18,
          //         ),
          //   ),
          //   onTap: () {
          //     Get.dialog(const AddPersonScreen());
          //   },
          // ),
          ListTile(
            leading: Icon(
              Icons.groups_2_rounded,
              size: 30,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Kişileri Düzenle',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 18,
                  ),
            ),
            onTap: () {
              pc.getScreen(8);
            },
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
