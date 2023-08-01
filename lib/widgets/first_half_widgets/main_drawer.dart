import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_test1/controllers/first_half_controllers/page_controller.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
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
                  'HESAPLA!',
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
              "Bölüştür! 'e Geç",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 18,
                  ),
            ),
            onTap: () {
              pc.goToSecondPart();
            },
          ),
          const Spacer(),
          Container(
            height: 50,
            width: double.infinity,
            alignment: Alignment.center,
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
            child: Text(
              'Hedefler',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 20,
                  ),
            ),
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: Icon(
              Icons.auto_graph_outlined,
              size: 30,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Birikim Hedeflerini Yönet (W.I.P.)',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 18,
                  ),
            ),
            onTap: () {
              pc.getScreen(6);
            },
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 30,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Harcama Hedeflerini Yönet (W.I.P.)',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 18,
                  ),
            ),
            onTap: () {
              pc.getScreen(5);
            },
          ),
          const SizedBox(height: 30),
          Container(
            height: 50,
            width: double.infinity,
            alignment: Alignment.center,
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
            child: Text(
              'Kategori Ayarları',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 20,
                  ),
            ),
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 30,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Harcama Kategorilerini Düzenle',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 18,
                  ),
            ),
            onTap: () {
              pc.getScreen(3);
            },
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 30,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Gelir Kategorilerini Düzenle',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 18,
                  ),
            ),
            onTap: () {
              pc.getScreen(4);
            },
          ),
          const SizedBox(height: 30),
          Container(
            height: 65,
            width: double.infinity,
            alignment: Alignment.center,
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
            child: IconButton(
              icon: const Icon(Icons.arrow_circle_right_outlined, size: 55),
              onPressed: () => Get.close(1),
            ),
          ),
        ],
      ),
    );
  }
}
