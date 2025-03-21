import 'package:banking_app/model/transaction_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key, this.filterType = 'All'});

  final String? filterType;

  @override
  Widget build(BuildContext context) {
    final filteredTransactions = transactions.where((transaction) {
      if (filterType == 'All' || filterType == null) {
        return true;
      }
      return transaction['transactionType'] == filterType!.toLowerCase();
    }).toList();

    return Padding(
      padding: EdgeInsets.only(bottom: 20.0.h),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: filteredTransactions.length,
        itemBuilder: (context, index) {
          final transaction = filteredTransactions.elementAt(index);
          return transactionCard(
            transaction['svgPath']!,
            transaction['name']!,
            transaction['time']!,
            transaction['amount']!,
            transaction['transactionType']!,
            'assets/icons/transfer.svg',
            'assets/icons/request.svg',
            context,
          );
        },
      ),
    );
  }
}

Widget transactionCard(
    String svgPath,
    String name,
    String time,
    String amount,
    String transactionType,
    String debitIcon,
    String creditIcon,
    BuildContext context) {
  Color statusColor;
  String statusIcon;

  if (transactionType == 'credit') {
    statusColor = Colors.green;
    statusIcon = creditIcon;
  } else {
    statusColor = Colors.red;
    statusIcon = debitIcon;
  }

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 5.h),
    child: Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black26, width: 0.2),
        color: Colors.white,
      ),
      child: Row(
        children: [
          SvgPicture.asset(svgPath, height: 35.h, width: 35.w),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                time,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12.sp,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                'Rs.$amount',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              SvgPicture.asset(
                statusIcon,
                height: 20.h,
                width: 20.w,
                colorFilter: ColorFilter.mode(statusColor, BlendMode.srcIn),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
