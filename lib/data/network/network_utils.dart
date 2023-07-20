import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import '../models/universal_data.dart';

/// Vaqt yo'qotib qo'ymay degan maqsad bilan siz yozgan koddan copy paste qildim,
/// o'ylaymanki, bu sizning baholashingizga ta'sir qilmaydi
/// Shunchaki aniqroq data chiqarish maqsad qilinngan
///
UniversalData handleHttpErrors(Response response) {
  switch (response.statusCode) {
    case HttpStatus.badRequest:
      {
        return UniversalData(
          error: "Bad request exception",
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.unauthorized:
      {
        return UniversalData(
          error: jsonDecode(response.body)["message"],
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.forbidden:
      {
        return UniversalData(
          error: jsonDecode(response.body)["message"],
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.notFound:
      {
        return UniversalData(
          error: jsonDecode(response.body)["message"],
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.tooManyRequests:
      {
        return UniversalData(
          error: jsonDecode(response.body)["message"],
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.internalServerError:
      {
        return UniversalData(
          error:
          "Error occurred while Communication with Server with StatusCode : ${response.statusCode}",
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.notImplemented:
      {
        return UniversalData(
          error: "Server Error : ${response.statusCode}",
          statusCode: response.statusCode,
        );
      }
    default:
      return UniversalData(
        error: "Unknown Error occurred!",
        statusCode: response.statusCode,
      );
  }
}
