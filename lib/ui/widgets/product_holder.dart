import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:third_exam_n8/data/local/database/database.dart';
import 'package:third_exam_n8/data/local/storage_repository/storage_repository.dart';
import 'package:third_exam_n8/data/models/sql/product_model_for_sql.dart';
import 'package:third_exam_n8/ui/widgets/show_toast.dart';
import 'package:third_exam_n8/utils/colors.dart';

import '../../data/models/api/product_model/product_model.dart';

class ProductHolder extends StatefulWidget {
  const ProductHolder(
      {super.key, required this.productModel, required this.listener});

  final VoidCallback listener;
  final ProductModel productModel;

  @override
  State<ProductHolder> createState() => _ProductHolderState();
}

class _ProductHolderState extends State<ProductHolder> {
  bool isSelected = false;

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
          // height: 160.h,
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
                    widget.productModel.imageUrl,
                    width: 140.w,
                    height: 130.h,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.productModel.name,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,
                ),
                Text(
                  "\$ ${widget.productModel.price}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(
                      fontWeight: FontWeight.w800, color: Colors.purple),
                ),
                SizedBox(height: 4.h),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      if(StorageRepository.getBool("${widget.productModel.id}AC")){
                        StorageRepository.deleteBool("${widget.productModel.id}AC");
                      }else{
                        StorageRepository.putBool("${widget.productModel.id}AC", true);
                      }
                    });

                    ProductModelSql productModelSql = ProductModelSql(
                      productId: widget.productModel.id,
                      count: 0,
                      name: widget.productModel.name,
                      price: widget.productModel.price,
                      imageUrl: widget.productModel.imageUrl,
                      cartId: widget.productModel.id
                    );

                    if(StorageRepository.getBool("${widget.productModel.id}AC")){
                      productModelSql = await LocalDatabase.insertProductForCart(productModelSql: productModelSql.copyWith(count: 1));
                      ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                              content: Text("${widget.productModel.name} is added to cart successfully!"),
                              duration: const Duration(milliseconds: 800),
                           ),
                      );

                    }else if(!StorageRepository.getBool("${widget.productModel.id}AC")){
                       await LocalDatabase.deleteProduct(productModelSql.productId);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: StorageRepository.getBool("${widget.productModel.id}AC")?Colors.amber:AppColors.black),
                  child: Text(
                    StorageRepository.getBool("${widget.productModel.id}AC")?
                        "     Saved     ":
                    "Add to Cart",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: StorageRepository.getBool("${widget.productModel.id}AC")?AppColors.black:Colors.amber),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            onPressed: () async {
              setState(() {
                if (StorageRepository.getBool("${widget.productModel.id}K")) {
                  StorageRepository.deleteBool("${widget.productModel.id}K");
                } else {
                  StorageRepository.putBool("${widget.productModel.id}K", true);
                  StorageRepository.putBool("${widget.productModel.id}L", true);
                }
              });
              ProductModelSql pms = ProductModelSql(
                productId: widget.productModel.id,
                count: 0,
                name: widget.productModel.name,
                price: widget.productModel.price,
                imageUrl: widget.productModel.imageUrl,
                cartId: widget.productModel.id
              );


              if (StorageRepository.getBool("${widget.productModel.id}K")) {
                pms =
                await LocalDatabase.insertProductForFav(productModelSql: pms);
                await StorageRepository.putInt(
                    "${pms.productId}", pms.productId);
              } else
              if (!(StorageRepository.getBool("${widget.productModel.id}K"))) {
                LocalDatabase.deleteProduct(
                    StorageRepository.getInt("${pms.productId}"));
              }
              widget.listener.call();
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: StorageRepository.getBool("${widget.productModel.id}K")
                ? const Icon(
              Icons.favorite,
              color: Colors.red,
            )
                : const Icon(
              Icons.favorite_outline,
            ),
          ))
    ]);
  }
}
