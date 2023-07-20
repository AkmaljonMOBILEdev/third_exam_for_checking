import 'package:third_exam_n8/data/models/universal_data.dart';
import 'package:third_exam_n8/data/network/providers/api_provider.dart';

import '../../models/api/product_model/product_model.dart';

class CategoryByIdRepository{
  final ApiProvider apiProvider;

  CategoryByIdRepository({required this.apiProvider});

  Future<List<ProductModel>> fetchProductsByCategoryId({required int id})async{
    UniversalData universalData = await apiProvider.getProductsByCategoryId(id: id);
    if(universalData.error.isEmpty){
      return universalData.data as List<ProductModel>;
    }
    return [];
  }
}