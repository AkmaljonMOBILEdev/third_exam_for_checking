import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/data/local/storage_repository/storage_repository.dart';
import 'package:third_exam_n8/data/network/repositories/products_repository.dart';
import 'package:third_exam_n8/ui/widgets/app_loader.dart';
import 'package:third_exam_n8/utils/app_routes.dart';
import '../../../data/models/api/product_model/product_model.dart';
import '../../../utils/colors.dart';
import '../../widgets/product_holder.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, required this.productRepository});
  final ProductRepository productRepository;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductModel> products = [];
  bool isLoading=false;
  
  _fetchData()async{
    setState(() {
      isLoading=true;
    });
    products = await widget.productRepository.fetchAllProducts();
    setState(() {
      isLoading=false;
    });
  }
  @override
  void initState() {
    _fetchData();
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
            statusBarBrightness: Brightness.light
        ),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, RouteNames.favouritesScreen, arguments: (v)
                {
                  StorageRepository.deleteBool("${v}K");
                  _fetchData();
                });
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(Icons.favorite,color: Colors.white,),
          ),
          SizedBox(width: 8.w,)
        ],
        title: Text('Products'),
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
        children: List.generate(products.length, (index) {
          return ProductHolder(
            listener: (){},
            productModel: products[index],
          );
        }),
      )
    );
  }
}
