import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/data/network/providers/api_provider.dart';
import 'package:third_exam_n8/data/network/repositories/category_by_id_repository.dart';
import 'package:third_exam_n8/ui/widgets/app_loader.dart';
import 'package:third_exam_n8/ui/widgets/product_holder.dart';

import '../../data/models/api/category_model/category_model.dart';
import '../../data/models/api/product_model/product_model.dart';
import '../../utils/colors.dart';

class ProductsByCategoriesScreen extends StatefulWidget {
  const ProductsByCategoriesScreen({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  State<ProductsByCategoriesScreen> createState() =>
      _ProductsByCategoriesScreenState();
}

class _ProductsByCategoriesScreenState
    extends State<ProductsByCategoriesScreen> {
  List<ProductModel> products = [];
  CategoryByIdRepository categoryByIdRepository=CategoryByIdRepository(apiProvider: ApiProvider());
  bool isLoading = false;

  _fetchData({required int id}) async {
    setState(() {
      isLoading = true;
    });

    products = await categoryByIdRepository.fetchProductsByCategoryId(id: id);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchData(id: widget.categoryModel.id);
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
        title: Text(widget.categoryModel.name),
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
      ),
    );
  }
}
