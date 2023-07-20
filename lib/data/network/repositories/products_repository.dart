import 'package:third_exam_n8/data/models/universal_data.dart';
import 'package:third_exam_n8/data/network/providers/api_provider.dart';

import '../../models/api/product_model/product_model.dart';

class ProductRepository{
  final ApiProvider apiProvider;

  ProductRepository({required this.apiProvider});

  Future<List<ProductModel>> fetchAllProducts()async{
    UniversalData universalData = await apiProvider.getAllProducts();
    if(universalData.error.isEmpty){
      return universalData.data as List<ProductModel>;
    }
    return [];
  }
}