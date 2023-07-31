import 'package:get/get.dart';
import 'package:self_test1/controllers/second_half_controllers/registered_persons_controller.dart';
import 'package:flutter/material.dart';
import 'package:self_test1/screens/second_half_screens/add_screens/add_person_screen.dart';
import 'package:self_test1/widgets/second_half_widgets/people_list/people_item.dart';

class PeopleList extends StatefulWidget {
  const PeopleList({super.key});

  @override
  State<PeopleList> createState() => _PeopleListState();
}

RegisteredPersonsController rpc = Get.find();

class _PeopleListState extends State<PeopleList> {
  void removePerson(index) {
    var item = rpc.personsList[index];
    rpc.personsList.removeAt(index);
    rpc.savePersons(rpc.personsList);
    Get.snackbar(
      'Başarılı',
      'Kategori Başarıyla Silindi',
      mainButton: TextButton(
          child: const Text('Geri Al'),
          onPressed: () {
            Get.closeCurrentSnackbar();
            setState(() {
              rpc.personsList.insert(index, item);
              rpc.savePersons(rpc.personsList);
            });
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: rpc.personsList.length,
            itemBuilder: (ctx, index) => Center(
              child: Dismissible(
                background: Container(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.error.withOpacity(0.50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: Theme.of(context).cardTheme.margin,
                ),
                key: ValueKey(rpc.personsList[index]),
                onDismissed: (direction) {
                  setState(() {
                    removePerson(index);
                  });
                },
                child: PeopleItem(rpc.personsList[index].name),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                await Get.dialog(const AddPersonScreen());
                setState(() {});
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  padding: const EdgeInsets.all(16),
                  width: 220,
                  height: 65,
                  margin: const EdgeInsets.all(12),
                  child: const Icon(Icons.add)),
            ),
            // InkWell(
            //   onTap: () {
            //     incomeController.resetCategory();
            //     Get.showSnackbar(const GetSnackBar(
            //       message: 'Kategoriler Başarıyla Sıfırlandı',
            //     ));
            //   },
            //   child: Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(15),
            //         color: Theme.of(context).colorScheme.secondaryContainer,
            //       ),
            //       padding: const EdgeInsets.all(12),
            //       height: 65,
            //       width: 65,
            //       alignment: Alignment.center,
            //       margin: const EdgeInsets.all(12),
            //       child: const Icon(Icons.restore)),
            // ),
          ],
        ),
      ],
    );
  }
}
