import 'dart:convert';
import 'package:http/http.dart';
import 'package:third_exam_n8/data/models/universal_data.dart';
import 'package:third_exam_n8/data/network/network_utils.dart';
import '../../models/api/category_model/category_model.dart';
import '../../models/api/product_model/product_model.dart';


class ApiProvider{
  Future<UniversalData> getAllProducts()async{
    Uri uri = Uri.parse("https://imtixon.free.mockoapp.net/products");
    try{
      Response response = await get(uri);
      if(response.statusCode==200){
        return UniversalData(
          data: (jsonDecode(response.body)["data"]as List?)
              ?.map((e) => ProductModel.fromJson(e)).toList() ?? []
        );
      }
      return handleHttpErrors(response);
    }catch(error){
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> getAllCategories()async{
    //1-usul: Bunda xatolik ko'rsatdi
    // Uri uri = Uri.https(baseUrlOfCategories,"/categories");
    //2-usul: Bunda ishladi
    Uri uri = Uri.parse("https://imtixon.free.mockoapp.net/categories");
    try{
      Response response = await get(uri);
      if(response.statusCode==200){
        return UniversalData(
          data: (jsonDecode(response.body)as List?)
              ?.map((e) => CategoryModel.fromJson(e)).toList() ?? []
        );
      }
      return handleHttpErrors(response);
    }catch(error){
      return UniversalData(
        error: error.toString()
      );
    }
  }
  
  Future<UniversalData> getProductsByCategoryId({required int id})async{
    Uri uri = Uri.parse("https://imtixon.free.mockoapp.net/categories/$id");
    try{
      Response response = await get(uri);
      if(response.statusCode==200){
        return UniversalData(
          data: (jsonDecode(response.body)as List?)
              ?.map((e) => ProductModel.fromJson(e)).toList() ?? []
        );
      }
      return handleHttpErrors(response);
    }catch(error){
      return UniversalData(error: error.toString());
    }
  }
}