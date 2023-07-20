import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/data/network/providers/api_provider.dart';
import 'package:third_exam_n8/data/network/repositories/category_repository.dart';
import 'package:third_exam_n8/data/network/repositories/products_repository.dart';
import 'package:third_exam_n8/ui/tab_box/cart_screen/cart_screen.dart';
import 'package:third_exam_n8/ui/tab_box/categories_screen/categories_screen.dart';
import 'package:third_exam_n8/ui/tab_box/products_screen/products_screen.dart';
import 'package:third_exam_n8/ui/tab_box/widgets/bottom_nav_items.dart';
import 'package:third_exam_n8/utils/colors.dart';

class TabBoxScreen extends StatefulWidget {
  const TabBoxScreen({super.key});

  @override
  State<TabBoxScreen> createState() => _TabBoxScreenState();
}

class _TabBoxScreenState extends State<TabBoxScreen> {
  ApiProvider apiProvider = ApiProvider();
  late CategoryRepository categoryRepository;
  late ProductRepository productRepository;
  int currentTabIndex = 0;
  List<Widget> screens = [];

  @override
  void initState() {
    categoryRepository = CategoryRepository(apiProvider: apiProvider);
    productRepository = ProductRepository(apiProvider: apiProvider);
    screens.addAll([
      CategoryScreen(categoryRepository: categoryRepository,),
      ProductsScreen(productRepository: productRepository,),
      CartScreen()
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: AppColors.white,
        showSelectedLabels: true,
        iconSize: 36.w,
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        onTap: (index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        currentIndex: currentTabIndex,
        items: [
          getBottomNavItem(icon:  Icon(Icons.category, size: 24.w,), label: "Categories"),
          getBottomNavItem(icon:  Icon(Icons.rectangle,size: 24.w,), label: "Products"),
          getBottomNavItem(icon:  Icon(Icons.shopping_bag,size: 24.w,), label: "Cart"),
        ]
      ),
    );
  }


}
