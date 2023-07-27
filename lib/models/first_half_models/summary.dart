import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat("dd/MM/y ");

const uuid = Uuid();

// enum SummaryCategory { gelir, gider }

// const categoryIcons = {
//   SummaryCategory.gelir: Icons.lunch_dining,
//   SummaryCategory.gider: Icons.flight_takeoff,
// };

class Summary {
  Summary(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  String title;
  double amount;
  DateTime date;
  String category;

  String get formattedDate {
    return formatter.format(date);
  }
}
