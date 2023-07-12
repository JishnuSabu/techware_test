import 'package:flutter/material.dart';
import 'package:flutter_machine_test/view/home/notifier/home.notifier.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductItemAddProduct extends StatelessWidget {
  final String name;
  final String price;
  final String calories;
  final String description;
  final ProductsNotifier productsNotifierData;
  final Map<String, dynamic> currentItem;

  const ProductItemAddProduct({
    Key? key,
    required this.name,
    required this.price,
    required this.calories,
    required this.description,
    required this.productsNotifierData,
    required this.currentItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Text(
                    "₹$price",
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "$calories Calories",
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                description,
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if(productsNotifierData.apiProductsModel[0].tableMenuList[0].categoryDishes[0].qty != 0){
                            productsNotifierData.removeQty();
                          }else{
                            productsNotifierData.deleteProduct(currentItem['key']);
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        currentItem['quantity'].toString(),
                        style: GoogleFonts.openSans(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        icon: const Icon(
                            Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          productsNotifierData.addQty();
                          print("bbb: "+currentItem.toString());
                        },
                      ),
                    ),
                  ],
                ),
              ),
              currentItem == 0 ? Text(
                "Customization Available",
                style: GoogleFonts.openSans(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ) : const SizedBox(),
            ],
          ),
        ),
        const SizedBox(height: 20.0,),
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          width: MediaQuery.of(context).size.width,
          height: 1.0,
          color: Colors.grey,
        ),
      ],
    );
  }
}
