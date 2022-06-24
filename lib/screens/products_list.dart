import 'package:cake_shop_app1/constants.dart';
import 'package:cake_shop_app1/main.dart';
import 'package:cake_shop_app1/screens/add_products.dart';
import 'package:cake_shop_app1/shared/cubit.dart';
import 'package:cake_shop_app1/shared/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductsListScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  final SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CakeShopCubit, CakeShopStates>(
        listener: (context, state) {
      if (state is AddProductSuccessStates) {
        Fluttertoast.showToast(
            msg: "product was added successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.yellow,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Center(
            child: Text(
              'Manage Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  CakeShopCubit.get(context).changeAppMode();
                },
                icon: Icon(Icons.brightness_4_outlined)),
          ],
        ),
        floatingActionButton: Theme(
          data: Theme.of(context).copyWith(
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: defaultColor,
                  extendedSizeConstraints:
                      BoxConstraints.tightFor(height: 40, width: 280))),
          child: new FloatingActionButton.extended(
            onPressed: () {
              navigateTO(context, AddProductsScreen());
            },
            label: Text('Add Product'),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(children: [
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  padding: EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    key: ValueKey('Search Product'),
                    controller: SearchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Search Product ',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'search product name,description,price';
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildProductsList(context),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 8.0,
                        ),
                    itemCount: 10),
              ]),
            ),
          ),
        ),
      );
    });
  }

  Widget buildProductsList(context) => Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Strawberry Cake',
                style: Theme.of(context).textTheme.bodyText1),
            SizedBox(height: 5.0),
            Text('Strawberry cake with cream',
                style: Theme.of(context).textTheme.caption),
            SizedBox(height: 5.0),
            Text(
              '12 K.D',
              style: TextStyle(color: defaultColor),
            )
          ]),
        ),
      );
}
