import 'package:flutter/material.dart';
import 'package:self_test1/screens/second_half_screens/activity_expenses_screen.dart';
import 'package:self_test1/screens/second_half_screens/activity_summary_screen.dart';
import 'package:self_test1/widgets/second_half_widgets/b_main_drawer.dart';

class BHomeScreen extends StatefulWidget {
  const BHomeScreen({super.key});

  @override
  State<BHomeScreen> createState() => _BHomeScreenState();
}

class _BHomeScreenState extends State<BHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController.index = 0;
  }

  static List<Widget> myTabs = <Widget>[
    const Tab(
      text: 'Düzenle',
      icon: Icon(Icons.account_tree_rounded),
      height: 60,
    ),
    const Tab(
      text: 'Özet',
      icon: Icon(Icons.list_alt_rounded),
      height: 60,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: const SecondDrawer(),
      bottomNavigationBar: Material(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(25),
        type: MaterialType.card,
        child: Row(
          children: [
            Expanded(
              child: TabBar(
                indicatorWeight: 4,
                tabs: myTabs,
                controller: _tabController,
              ),
            ),
            EndDrawerButton(
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(60, 60)),
                    maximumSize: null)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const ActivityExpensesScreen(),
          ActivitySummaryScreen(),
        ],
      ),
    );
  }
}

/*

Drawer(
  Kişileri Düzenle Sayfası(
  -Grup Olarak Kaydet
  -Kişi Ekle
  -Kişi Çıkart
  )
  Kayıtlı Gruplar Sayfası(
  -Grubu Yükle
  -Grubu Düzenle
  -Grubu Sil
  )
  Kayıtlı Etkinlikler Sayfası(
    -Etkinliği Yükle
    -Etkinliği Sil
    -Özet Göster (Sayfa Şeklinde)
  )
)

Özet Sayfası(
  Grafik - Harcama Kategorileri Yüzdelik
  Kişi Listesi - Kişilerin Toplam Harcama Miktarları(
    Kişi item (
    Tıklandığında:  (Kişi Detaylı Özet Sayfası)
      -Kişinin Dahil Olduğu Bütün Harcamalar ve 
      -Harcamalardaki Payı ve
      -Toplam Harcaması Gösterilecek
    )
  )
  Toplam Harcama Kartı - double total 
)

Düzenleme Sayfası(
  -Harcama Ekle-Çıkart
  -Etkinlik Olarak Kaydet
)



*/