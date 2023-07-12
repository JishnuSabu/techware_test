import 'package:flutter/material.dart';
import 'package:flutter_machine_test/common/widgets/productItems.dart';
import 'package:flutter_machine_test/view/home/notifier/home.notifier.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    final productsNotifierData = Provider.of<ProductsNotifier>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: productsNotifierData.apiProductsData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _tabController = TabController(length: productsNotifierData.apiProductsModel[0].tableMenuList.length, vsync: this);
            for(int i =0; i<productsNotifierData.apiProductsModel[0].tableMenuList[0].categoryDishes.length-1; i++){
              productsNotifierData.apiProductsModel[0].tableMenuList[0].categoryDishes[i].qty = 0;
            }
            productsNotifierData.refreshItems();
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 5,
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      Navigator.of(context).pushNamed("/addProduct");
                    },
                    icon: Consumer<ProductsNotifier>(builder: (context, data, _) {
                        return badges.Badge(
                          badgeContent: Text(
                            productsNotifierData.products.length.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          badgeStyle: const badges.BadgeStyle(
                            badgeColor: Colors.red,
                          ),
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.grey.shade700,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              body: DefaultTabController(
                length: productsNotifierData.apiProductsModel[0].tableMenuList.length,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    bottom: TabBar(
                        indicatorColor: Colors.pink,
                        labelColor: Colors.pink,
                        unselectedLabelColor: Colors.black,
                        controller: _tabController,
                        tabs: productsNotifierData.apiProductsModel[0].tableMenuList.map((e) => Text(e.menuCategory)).toList()
                    ),
                  ),
                  body: TabBarView(
                    controller: _tabController,
                    children: productsNotifierData.apiProductsModel[0].tableMenuList[0].categoryDishes.map((e) => CategoryTabView(
                      name: e.dishName,
                      price: e.dishPrice.toString(),
                      calories: e.dishCalories.toString(),
                      description: e.dishDescription,
                      quantity: productsNotifierData.apiProductsModel[0].tableMenuList[0].categoryDishes[0].qty.toString(),
                    ),).toList(),
                    // children: [
                    //   for(int i = 0; i <= productsNotifierData.apiProductsModel[0].tableMenuList.length; i++)
                    //   for(int j = 0; j <= productsNotifierData.apiProductsModel[0].tableMenuList[i].categoryDishes.length; i++)
                    //     CategoryTabView(
                    //       name: productsNotifierData.apiProductsModel[0].tableMenuList[i].categoryDishes[j].dishName,
                    //       price: productsNotifierData.apiProductsModel[0].tableMenuList[i].categoryDishes[j].dishPrice.toString(),
                    //       calories: productsNotifierData.apiProductsModel[0].tableMenuList[i].categoryDishes[j].dishCalories.toString(),
                    //       description: productsNotifierData.apiProductsModel[0].tableMenuList[i].categoryDishes[j].dishDescription,
                    //     ),
                    // ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class CategoryTabView extends StatelessWidget {

  final String name;
  final String price;
  final String calories;
  final String description;
  final String quantity;

  const CategoryTabView({
    Key? key,
    required this.name,
    required this.price,
    required this.calories,
    required this.description,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsNotifierData = Provider.of<ProductsNotifier>(context, listen: false);
    return ListView.builder(
        itemCount: productsNotifierData.apiProductsModel[0].tableMenuList[0].categoryDishes.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return Consumer<ProductsNotifier>(builder: (context, data, _) {
            return ProductItem(
              name: name,
              price: price,
              calories: calories,
              description: description,
              quantity: quantity,
              productsNotifierData: productsNotifierData,
            );
          });
        });
  }
}



