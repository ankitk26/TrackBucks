import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:trackbucks/models/models.dart";

final myUpi = dotenv.get('UPI');
final transactionsAPIEndpoint = dotenv.get('TRANSACTIONS_DATA_API');

const appGreen = Color(0xffCAFAC4);

final years = MonthModel(monthName: '2023', monthNumber: 2023);

final months = [
  MonthModel(monthName: 'January', monthNumber: 1),
  MonthModel(monthName: 'February', monthNumber: 2),
  MonthModel(monthName: 'March', monthNumber: 3),
  MonthModel(monthName: 'April', monthNumber: 4),
  MonthModel(monthName: 'May', monthNumber: 5),
  MonthModel(monthName: 'June', monthNumber: 6),
  MonthModel(monthName: 'July', monthNumber: 7),
  MonthModel(monthName: 'August', monthNumber: 8),
  MonthModel(monthName: 'September', monthNumber: 9),
  MonthModel(monthName: 'October', monthNumber: 10),
  MonthModel(monthName: 'November', monthNumber: 11),
  MonthModel(monthName: 'December', monthNumber: 12),
];

enum TransactionType { send, receive }
