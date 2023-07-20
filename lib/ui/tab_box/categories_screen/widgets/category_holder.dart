import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/utils/colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../data/models/api/category_model/category_model.dart';

class CategoryHolder extends StatefulWidget {
  const CategoryHolder({super.key, required this.category, required this.listener});
  final CategoryModel category;
  final VoidCallback listener;

  @override
  State<CategoryHolder> createState() => _CategoryHolderState();
}

class _CategoryHolderState extends State<CategoryHolder> {
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: (){
        widget.listener.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        // height: 80.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.black,
            width: 1.w
          )
        ),
        child: Row(
          children: [
            Image.network(widget.category.imageUrl, fit: BoxFit.cover,width: 100.w,height: 100.h,),
            SizedBox(width: 40.w,),
            Text(widget.category.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w800
            ))
          ],
        ),
      ),
    );
  }
}
