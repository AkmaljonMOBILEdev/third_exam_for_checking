import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/data/local/database/database.dart';
import 'package:third_exam_n8/data/models/sql/product_model_for_sql.dart';
import 'package:third_exam_n8/utils/colors.dart';

import '../../../data/local/storage_repository/storage_repository.dart';

class ProductHolderForSql extends StatefulWidget {
  const ProductHolderForSql(
      {super.key, required this.productModelSql, required this.listener});

  final VoidCallback listener;
  final ProductModelSql productModelSql;

  @override
  State<ProductHolderForSql> createState() => _ProductHolderForSqlState();
}

class _ProductHolderForSqlState extends State<ProductHolderForSql> {
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          width: 170.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.black, width: 1.w)),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.network(
                    widget.productModelSql.imageUrl,
                    width: 140.w,
                    height: 130.h,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  widget.productModelSql.name,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "\$ ${widget.productModelSql.price}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w800, color: Colors.purple),
                ),
                SizedBox(height: 4.h),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      if (StorageRepository.getBool(
                          "${widget.productModelSql.productId}AC")) {
                        StorageRepository.deleteBool(
                            "${widget.productModelSql.productId}AC");
                      } else {
                        StorageRepository.putBool(
                            "${widget.productModelSql.productId}AC", true);
                      }
                    });
                    ProductModelSql productModelSql = ProductModelSql(
                        productId: widget.productModelSql.productId,
                        count: 0,
                        name: widget.productModelSql.name,
                        price: widget.productModelSql.price,
                        imageUrl: widget.productModelSql.imageUrl,
                        cartId: widget.productModelSql.productId,
                    );

                    if (StorageRepository.getBool(
                        "${widget.productModelSql.productId}AC")) {
                      productModelSql =
                          await LocalDatabase.insertProductForCart(
                              productModelSql:
                                  productModelSql.copyWith(count: 1));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${widget.productModelSql.name} is added to cart successfully!"),
                              duration: const Duration(milliseconds: 800),
                            ),
                          );
                    } else if (!StorageRepository.getBool(
                        "${widget.productModelSql.productId}AC")) {
                      await LocalDatabase.deleteProduct(
                          productModelSql.productId);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: StorageRepository.getBool(
                              "${widget.productModelSql.productId}AC")
                          ? Colors.amber
                          : AppColors.black),
                  child: Text(
                    StorageRepository.getBool(
                            "${widget.productModelSql.productId}AC")
                        ? "     Saved     "
                        : "Add to Cart",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: StorageRepository.getBool(
                                "${widget.productModelSql.productId}AC")
                            ? AppColors.black
                            : Colors.amber),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      Positioned(
          right: 0.w,
          top: 0.h,
          child: IconButton(
              onPressed: () async {
                setState(() {
                  isSelected = false;
                });
                LocalDatabase.deleteProduct(StorageRepository.getInt(
                    "${widget.productModelSql.productId}"));
                StorageRepository.deleteBool(
                    "${widget.productModelSql.productId}K");
                widget.listener.call();
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: isSelected
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_outline,
                    )))
    ]);
  }
}
