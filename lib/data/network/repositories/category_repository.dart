import 'package:third_exam_n8/data/network/providers/api_provider.dart';
import '../../models/api/category_model/category_model.dart';
import '../../models/universal_data.dart';

class CategoryRepository{
  final ApiProvider apiProvider;

  CategoryRepository({required this.apiProvider});

  Future<List<CategoryModel>> fetchCategories()async{
    UniversalData universalData = await apiProvider.getAllCategories();
    if(universalData.error.isEmpty){
      return universalData.data as List<CategoryModel>;
    }
    return [];
  }
}