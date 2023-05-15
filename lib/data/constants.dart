import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:trackbucks/models/month.dart";

const myUpi = '9723750157@paytm';

const appBlue = Color(0xff4339D7);
const appGreen = Color(0xffCAFAC4);
const appPaper = Color(0xff181818);
const appBlack = Colors.black;

typedef FirestoreSnapshots = Stream<QuerySnapshot<Map<String, dynamic>>>;

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
