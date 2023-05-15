import 'package:flutter/material.dart';
import 'package:trackbucks/data/constants.dart';
import 'package:trackbucks/widgets/widgets.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  static const path = '/add-transaction';

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  TextEditingController payeeName = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController upiId = TextEditingController();
  TransactionType transactionType = TransactionType.send;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transaction"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  TransactionTypeContainer(
                    transactionType: TransactionType.send,
                    icon: Icons.arrow_upward,
                    label: "Send",
                    selectedTransactionType: transactionType,
                  ),
                  const SizedBox(width: 8.0),
                  TransactionTypeContainer(
                    transactionType: TransactionType.receive,
                    icon: Icons.arrow_downward,
                    label: "Receive",
                    selectedTransactionType: transactionType,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
