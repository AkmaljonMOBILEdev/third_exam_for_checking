import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/sql/product_model_for_sql.dart';
import '../../../../utils/colors.dart';

class TotalAmount extends StatefulWidget {
  const TotalAmount({super.key,  required this.products});
  final List<ProductModelSql> products;

  @override
  State<TotalAmount> createState() => _TotalAmountState();
}

class _TotalAmountState extends State<TotalAmount> {
  int sum=0;
  int _totalAmount(){
    setState(() {
      sum = widget.products.fold(0, (total, product) => total + (product.price*product.count));
    });
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      width: double.infinity,
      height: 80.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.purple,
          border: Border.all(
              color: AppColors.black,
              width: 1.w
          )
      ),
      child: Row(
        children: [
          Text("Total amount : ",style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w800, color: AppColors.white, fontSize: 18.sp
          ),),
          SizedBox(width: 20.w,),
          Text("\$ ${_totalAmount()}", style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w800, color: Colors.amber, fontSize: 20.sp
          ),)

        ],
      ),

    );
  }
}
