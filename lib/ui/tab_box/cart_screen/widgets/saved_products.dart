import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/data/models/sql/product_model_for_sql.dart';

import '../../../../data/local/database/database.dart';
import '../../../../data/local/storage_repository/storage_repository.dart';

class SavedProducts extends StatefulWidget {
  const SavedProducts(
      {super.key, required this.productModelSql, required this.listener});

  final ProductModelSql productModelSql;
  final VoidCallback listener;

  @override
  State<SavedProducts> createState() => _SavedProductsState();
}

class _SavedProductsState extends State<SavedProducts> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4.r),
        child: Image.network(
          widget.productModelSql.imageUrl,
          fit: BoxFit.cover,
          width: 60.w,
          height: 70.h,
        ),
      ),
      title: Text(widget.productModelSql.name),
      subtitle: RichText(
          text: TextSpan(
              text: "Count :   ",
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
            TextSpan(
                text: widget.productModelSql.count.toString(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w700, color: Colors.amber)),
            TextSpan(
                text: "   x   ", style: Theme.of(context).textTheme.bodyMedium),
            TextSpan(
                text: "\$ ${widget.productModelSql.price}",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w800, color: Colors.purple))
          ])),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () async {
              LocalDatabase.increaseProductCount(
                  productModelSql: widget.productModelSql);
              widget.listener.call();
            },
            icon: Icon(Icons.plus_one, color: Colors.green),
          ),
          IconButton(
              onPressed: () async {
                if (widget.productModelSql.count > 0) {
                  LocalDatabase.decreaseProductCount(
                      productModelSql: widget.productModelSql);
                }

                if (widget.productModelSql.count == 1) {
                  await LocalDatabase.deleteProductByCart(
                      widget.productModelSql.cartId);
                  StorageRepository.deleteBool(
                      "${widget.productModelSql.cartId}AC");
                  StorageRepository.deleteBool("${widget.productModelSql.id}AC");

                }

                widget.listener.call();
              },
              icon: Icon(
                Icons.exposure_minus_1,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
