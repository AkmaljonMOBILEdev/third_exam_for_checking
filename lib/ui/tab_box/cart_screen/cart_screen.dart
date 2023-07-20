import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/data/local/database/database.dart';
import 'package:third_exam_n8/data/local/storage_repository/storage_repository.dart';
import 'package:third_exam_n8/ui/tab_box/cart_screen/widgets/saved_products.dart';
import 'package:third_exam_n8/ui/tab_box/cart_screen/widgets/total_amount.dart';
import 'package:third_exam_n8/ui/widgets/app_loader.dart';

import '../../../data/models/sql/product_model_for_sql.dart';
import '../../../utils/colors.dart';
/// Imtihon apk dan biroz farqli ravishda Cart screen'ning UX va UI qismiga
/// o'zgartirish kiritildi, sabab - haqiqiy e-commerce applarga yanayam o'xshatish
class CartScreen extends StatefulWidget {
  const CartScreen({super.key,});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<ProductModelSql> products = [];
  bool isLoading=false;
  int sum=0;
  _fetch()async{
    setState(() {
      isLoading=true;
    });
    products = await LocalDatabase.getProductsForCart();
    setState(() {
      isLoading=false;
    });
  }

  @override
  void initState() {
    _fetch();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.black,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light),
        title: const Text('Cart'),
        actions: [
          GestureDetector(
            onTap: () {
              if(products.isNotEmpty){
                _getAsk(products);
              }


            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
              child: Text(
                'Clear all',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.amber, fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      ),
      body: isLoading?AppLoader()
            :
            Column(
              children: [
                Expanded(
                  child: ListView(
                      children: [
                        ...List.generate(products.length, (index){
                          return SavedProducts(productModelSql: products[index], listener: (){

                            setState(() {
                              _fetch();

                            });
                          },);

                        })
                      ],
                    ),
                ),
                TotalAmount(products: products,)

              ],
            ),
    );
  }

  _getAsk(List<ProductModelSql> helperProducts) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r)
            ),
            child: Container(
              height: 180.h,

              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.black,
                  width: 1.w
                ),
                borderRadius: BorderRadius.circular(16.r)
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Text('Are you sure delete all products?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          LocalDatabase.deleteAllInCart();
                          for(int i=0; i<helperProducts.length; i++){
                            if(StorageRepository.getBool("${helperProducts[i].productId}AC")){
                              StorageRepository.deleteBool("${helperProducts[i].productId}AC");
                            }
                          }
                          setState(() {
                            _fetch();
                          });
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text('Yes', style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.red
                        ),),
                      ),
                      SizedBox(width: 50.w,),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("No",style: Theme.of(context).textTheme.titleMedium,))
                    ],
                  )
                ],
              ),
            )

          );
        }
    );
  }

}

