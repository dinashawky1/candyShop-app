import 'package:cake_shop_app1/constants.dart';
import 'package:cake_shop_app1/screens/products_list.dart';
import 'package:cake_shop_app1/screens/products_list.dart';
import 'package:cake_shop_app1/shared/cubit.dart';
import 'package:cake_shop_app1/shared/states.dart';
import 'package:cake_shop_app1/viewModel/AddProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddProductsScreen extends StatelessWidget {
  final ProductNameController = TextEditingController();
  final ProductDescriptionController = TextEditingController();
  final ProductPriceController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  AddProductModel? addProductModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CakeShopCubit, CakeShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AddProductModel? addProductModel =
            CakeShopCubit.get(context).addProductModel;
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                navigateTO(context, ProductsListScreen());
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined),
            ),
            title: Text(
              'Add Product',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      padding: EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                          controller: ProductNameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Product Name ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                          ),
                          validator: (String? value) {
                            if (value!.length < 3) {
                              return 'input should be 3 characters or more';
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      padding: EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                          controller: ProductDescriptionController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Product Description ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                          ),
                          validator: (String? value) {
                            if (value!.length < 3) {
                              return 'input should be 3 characters or more';
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      padding: EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                          controller: ProductPriceController,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Product Price ',
                            suffix: Text('K.D'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'required field';
                            }
                          }),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: defaultColor,
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            CakeShopCubit.get(context).addProduct(
                              name: ProductNameController.text,
                              description: ProductDescriptionController.text,
                              price: ProductPriceController.text,
                            );
                          }
                        },
                        child: const Text(
                          'Submit',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
