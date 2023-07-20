import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/data/local/database/database.dart';
import 'package:third_exam_n8/data/models/api/product_model/product_model.dart';
import 'package:third_exam_n8/ui/favourites_screen/widgets/product_holder_for_sql.dart';
import 'package:third_exam_n8/ui/widgets/app_loader.dart';
import '../../data/models/sql/product_model_for_sql.dart';
import '../../utils/colors.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key, required this.listener});
  final ValueChanged listener;

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<ProductModelSql> favouriteProducts = [];
  List<ProductModel> products = [];
  bool isLoading=false;

  _getFavourites()async{
    setState(() {
      isLoading=true;
    });
    favouriteProducts = await LocalDatabase.getProductsForFavourites();
    setState(() {
      isLoading=false;
    });
  }

  @override
  void initState() {
    _getFavourites();
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
        title: Text("Favourites"),
      ),
      body: isLoading
          ? const AppLoader()
          : GridView.count(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 20.h),
        physics: const BouncingScrollPhysics(),
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 8.w,
        childAspectRatio: .68.h,
        crossAxisCount: 2,
        children: List.generate(favouriteProducts.length, (index) {
          return ProductHolderForSql(productModelSql: favouriteProducts[index], listener: (){
            widget.listener.call(favouriteProducts[index].productId);
            setState(() {
              _getFavourites();
            });
          },);
        }),
      ),
    );
  }
}
