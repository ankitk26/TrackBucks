import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  double amount;
  String payeeName;
  String receiverUpi;
  String senderUpi;
  Timestamp transactionDate;
  int upiRefId;

  TransactionModel({
    required this.amount,
    required this.payeeName,
    required this.receiverUpi,
    required this.senderUpi,
    required this.transactionDate,
    required this.upiRefId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        amount: json["Amount"]?.toDouble(),
        payeeName: json["PayeeName"],
        receiverUpi: json["ReceiverUPI"],
        senderUpi: json["SenderUPI"],
        transactionDate: json["TransactionDate"],
        upiRefId: json["UPIRefId"],
      );

  Map<String, dynamic> toJson() => {
        "Amount": amount,
        "PayeeName": payeeName,
        "ReceiverUPI": receiverUpi,
        "SenderUPI": senderUpi,
        "TransactionDate": transactionDate,
        "UPIRefId": upiRefId,
      };
}
