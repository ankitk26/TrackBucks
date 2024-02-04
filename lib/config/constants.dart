import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:trackbucks/features/transactions/domain/models/export.dart";

// Get secret values
final myUpi = dotenv.get('UPI');
final transactionsAPIEndpoint = dotenv.get('TRANSACTIONS_DATA_API');

final years = MonthEntity(monthName: '2023', monthNumber: 2023);

final months = [
  MonthEntity(monthName: 'January', monthNumber: 1),
  MonthEntity(monthName: 'February', monthNumber: 2),
  MonthEntity(monthName: 'March', monthNumber: 3),
  MonthEntity(monthName: 'April', monthNumber: 4),
  MonthEntity(monthName: 'May', monthNumber: 5),
  MonthEntity(monthName: 'June', monthNumber: 6),
  MonthEntity(monthName: 'July', monthNumber: 7),
  MonthEntity(monthName: 'August', monthNumber: 8),
  MonthEntity(monthName: 'September', monthNumber: 9),
  MonthEntity(monthName: 'October', monthNumber: 10),
  MonthEntity(monthName: 'November', monthNumber: 11),
  MonthEntity(monthName: 'December', monthNumber: 12),
];

enum TransactionType { send, receive }

enum FilterType { yearly, monthly }
