import 'package:flutter/material.dart';
import 'package:flutter_machine_test/view/home/model/api_products.model.dart';
import 'package:flutter_machine_test/view/home/networking/home.networking.dart';
import 'package:flutter_machine_test/view/home/view/tabs/tabitems/first_tab_item.dart';
import 'package:flutter_machine_test/view/home/view/tabs/tabitems/second_tab_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductsNotifier extends ChangeNotifier {
  final ProductsNetworking _productsNetworking = ProductsNetworking();

  late List<ApiProductsModel> apiProductsModel;
  bool isLoading = false;
  List<Map<String, dynamic>> products = [];
  final box = Hive.box('mybox');
  var qty = 0;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future apiProductsData() async {
    // loading(true);
    try {
      apiProductsModel = await _productsNetworking.apiProductsData();
      loading(false);
    } catch (e) {
      loading(false);
      // throw Exception(e);
    }
    loading(false);
    return apiProductsModel;
  }

  void refreshItems() {
    final item = box.keys.map((key) {
      final value = box.get(key);
      return {
        "key": key,
        "name": value["name"],
        "price": value['price'],
        "calories": value['calories'],
        "description": value['description'],
        "quantity": value['quantity']
      };
    }).toList();
    products = item.reversed.toList();
    notifyListeners();
  }

  Future<void> addProduct(Map<String, dynamic> newItem) async {
    await box.add(newItem);
    refreshItems();
  }

  Future<void> deleteProduct(int itemkey) async{
    await box.delete(itemkey);
    refreshItems();
  }


  addQty(){
    for(int i =0; i<apiProductsModel[0].tableMenuList[0].categoryDishes.length-1; i++){
      apiProductsModel[0].tableMenuList[0].categoryDishes[i].qty = apiProductsModel[0].tableMenuList[0].categoryDishes[i].qty! + 1;
    }
    notifyListeners();
  }

  removeQty(){
    for(int i =0; i<apiProductsModel[0].tableMenuList[0].categoryDishes.length-1; i++){
      apiProductsModel[0].tableMenuList[0].categoryDishes[i].qty = apiProductsModel[0].tableMenuList[0].categoryDishes[i].qty! - 1;
    }
    notifyListeners();
  }

}
