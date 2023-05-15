import 'package:flutter/material.dart';
import 'package:trackbucks/data/constants.dart';

class PaperCard extends StatelessWidget {
  final String title, value;
  final Color? cardColor;
  final Widget? icon;
  const PaperCard({
    super.key,
    required this.title,
    required this.value,
    this.cardColor = appPaper,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                value,
                // "₹${totalTransactions.toString()}",
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          icon ?? Container(),
        ],
      ),
    );
  }
}
