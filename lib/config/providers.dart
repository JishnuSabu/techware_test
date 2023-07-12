import 'package:flutter_machine_test/view/home/notifier/home.notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [

  ChangeNotifierProvider<ProductsNotifier>(create: (context) => ProductsNotifier()),

];