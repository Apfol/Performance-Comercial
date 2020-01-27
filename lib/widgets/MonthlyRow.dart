import 'package:comercial_performance/entities/monthly-report.dart';
import 'package:comercial_performance/utils/rowType.dart';
import 'package:flutter/material.dart';
import 'package:comercial_performance/utils/utils.dart' as utils;

class MonthlyRow extends StatelessWidget {
  final MonthlyReport monthlyReport;
  final RowType rowType;

  MonthlyRow({
    this.monthlyReport,
    this.rowType,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget number;

    switch (rowType) {
      case RowType.netEarning:
        number = Text(
          utils.currencyFormat.format(monthlyReport.netEarning),
          style: TextStyle(
              color: utils.primaryColor, fontSize: 16, letterSpacing: .3),
        );
        break;
      case RowType.commission:
        number = Text(
          utils.currencyFormat.format(monthlyReport.commission),
          style: TextStyle(
              color: utils.primaryColor, fontSize: 16, letterSpacing: .3),
        );
        break;
      case RowType.profit:
        number = Text(
          utils.currencyFormat.format(monthlyReport.profit),
          style: TextStyle(
              color: utils.primaryColor, fontSize: 16, letterSpacing: .3),
        );
        break;
      default:
    }

    return Container(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                monthlyReport.month,
                style: TextStyle(
                    color: utils.primaryColor, fontSize: 16, letterSpacing: .3),
              ),
              number
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            height: 4,
          )
        ],
      ),
    );
  }
}
