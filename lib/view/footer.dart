import 'package:banking_app/screens/all_transactions_list.dart';
import 'package:banking_app/widgets/recipients_list.dart';
import 'package:banking_app/widgets/transaction_list.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return Expanded(
      child: FadingEdgeScrollView.fromScrollView(
        gradientFractionOnEnd: 0.1,
        gradientFractionOnStart: 0.1,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0.w),
                    child: Text(
                      "Recent Recipients",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 18.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                    child: RecipientsList(),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0.w),
                    child: Row(
                      children: [
                        Text(
                          "Transactions",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 18.sp,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const AllTransactionsList(),
                                transition: Transition.downToUp,
                                duration: 300.ms,
                                curve: Curves.easeIn);
                          },
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.black26, width: 0.2),
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(6.r),
                                  left: Radius.circular(6.r),
                                ),
                              ),
                              minimumSize: Size(40.w, 20.h),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black),
                          child: Text(
                            'View all',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 14.sp,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                          ),
                        ).animate().shimmer()
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0.w),
                    child: const TransactionList().animate().moveY(
                        duration: 600.ms, begin: 120.0, curve: Curves.easeIn),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
