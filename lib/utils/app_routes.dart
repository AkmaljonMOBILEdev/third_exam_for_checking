import 'package:flutter/material.dart';
import 'package:third_exam_n8/data/models/sql/product_model_for_sql.dart';
import 'package:third_exam_n8/data/network/repositories/category_repository.dart';
import 'package:third_exam_n8/data/network/repositories/products_repository.dart';
import 'package:third_exam_n8/ui/favourites_screen/favourites_screen.dart';
import 'package:third_exam_n8/ui/products_by_categories_screen/products_by_categories_screen.dart';
import 'package:third_exam_n8/ui/tab_box/cart_screen/cart_screen.dart';
import 'package:third_exam_n8/ui/tab_box/categories_screen/categories_screen.dart';
import 'package:third_exam_n8/ui/tab_box/products_screen/products_screen.dart';

import '../data/models/api/category_model/category_model.dart';
import '../ui/tab_box/tab_box.dart';

class RouteNames{
  static const String tabBox = '/';
  static const String categoriesScreen = '/categories_screen';
  static const String productsScreen = '/products_screen';
  static const String cartScreen = '/cart_screen';
  static const String favouritesScreen = '/favourites_screen';
  static const String productsByCategoriesScreen = '/products_by_categories_screen';
}

class AppRoute{
  static Route generateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteNames.tabBox:
        return MaterialPageRoute(builder: (context)=> const TabBoxScreen());
      case RouteNames.categoriesScreen:
        return MaterialPageRoute(builder: (context)=> CategoryScreen(
          categoryRepository: settings.arguments as CategoryRepository,
        ));
      case RouteNames.productsScreen:
        return MaterialPageRoute(builder: (context)=>  ProductsScreen(
          productRepository: settings.arguments as ProductRepository,
        ));
      case RouteNames.cartScreen:
        return MaterialPageRoute(builder: (context)=>  CartScreen(
        ));
      case RouteNames.favouritesScreen:
        return MaterialPageRoute(builder: (context)=>  FavouritesScreen(
          listener: settings.arguments as ValueChanged,
        ));
      case RouteNames.productsByCategoriesScreen:
        return MaterialPageRoute(builder: (context)=>  ProductsByCategoriesScreen(
          categoryModel: settings.arguments as CategoryModel,
        ));

      default:
        return MaterialPageRoute(builder: (context){
          return const Scaffold();
        });
    }

  }
}