import 'package:flutter/material.dart';
import 'package:flutter_machine_test/common/appStrings/app_strings.dart';
import 'package:flutter_machine_test/common/widgets/productItemsAddProduct.dart';
import 'package:flutter_machine_test/view/home/notifier/home.notifier.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final productsNotifierData =
          Provider.of<ProductsNotifier>(context, listen: false);
      productsNotifierData.refreshItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsNotifierData = Provider.of<ProductsNotifier>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        automaticallyImplyLeading: true,
        shadowColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          AppStrings().orderSummery,
          style: GoogleFonts.openSans(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<ProductsNotifier>(builder: (context, data, _) {
        return productsNotifierData.products.isEmpty ? Center(
          child: Text(
            "Empty",
            style: GoogleFonts.openSans(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ) : SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Card(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "${productsNotifierData.products.length} Dishes - ${productsNotifierData.qty} Items",
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      ListView.builder(
                        itemCount: productsNotifierData.products.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final currentItem = productsNotifierData.products[index];
                          return ProductItemAddProduct(
                            name: productsNotifierData.products[index]['name'],
                            price: productsNotifierData.products[index]['price'],
                            calories: productsNotifierData.products[index]['calories'],
                            description: productsNotifierData.products[index]['description'],
                            productsNotifierData: productsNotifierData,
                            currentItem: currentItem,
                          );
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Amount",
                              style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "₹price",
                              style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 50.0, right: 50.0),
                        margin: const EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Place Order",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
