import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoneyBox extends StatelessWidget {
  final String title;
  final double amount;
  final double sizeConHeight;
  final Color colorset;

  MoneyBox({
    Key? key,
    required this.title,
    required this.amount,
    required this.sizeConHeight,
    required this.colorset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
      decoration: BoxDecoration(
        color: colorset,
        borderRadius: BorderRadius.circular(20),
      ),
      height: sizeConHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              '${NumberFormat("#,###.###").format(amount)}',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
