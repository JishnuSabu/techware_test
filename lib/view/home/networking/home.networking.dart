import 'package:flutter_machine_test/common/appStrings/app_strings.dart';
import 'package:flutter_machine_test/view/home/model/api_products.model.dart';
import 'package:http/http.dart' as http;


class ProductsNetworking {

  static String urlENDPOINT = AppStrings().url;

  final client = http.Client();

  late List<ApiProductsModel> apiProductsModel;

  Future<List<ApiProductsModel>> apiProductsData() async {
    try {
      final request = await client.get(Uri.parse(urlENDPOINT));
      if (request.statusCode == 200) {
        var response = request.body;
        apiProductsModel = apiProductsModelFromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return apiProductsModel;
  }
}
