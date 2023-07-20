import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:third_exam_n8/data/network/repositories/category_repository.dart';
import 'package:third_exam_n8/ui/tab_box/categories_screen/widgets/category_holder.dart';
import 'package:third_exam_n8/ui/widgets/app_loader.dart';
import 'package:third_exam_n8/utils/app_routes.dart';
import 'package:third_exam_n8/utils/colors.dart';
import '../../../data/models/api/category_model/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.categoryRepository});

  final CategoryRepository categoryRepository;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel> categories = [];
  bool isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    categories = await widget.categoryRepository.fetchCategories();
    setState(() {
      isLoading = false;
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
              statusBarBrightness: Brightness.light),
          title: Text('Categories'),
        ),
        body: isLoading
            ? const AppLoader()
            : ListView(
                physics: const BouncingScrollPhysics(),
                children: List.generate(categories.length, (index) {
                  return CategoryHolder(
                    category: categories[index],
                    listener: () {
                      Navigator.pushNamed(context, RouteNames.productsByCategoriesScreen,arguments: categories[index]);
                    },
                  );
                })));
  }
}

// [
// CategoryHolder(category: categories[0], listener: (){}),
// CategoryHolder(category: categories[1], listener: (){}),
// CategoryHolder(category: categories[2], listener: (){}),
// CategoryHolder(category: categories[3], listener: (){}),
// CategoryHolder(category: categories[4], listener: (){}),
// ],
