import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cake_shop_app1/network/cacheHelper.dart';
import 'package:cake_shop_app1/screens/add_products.dart';
import 'package:cake_shop_app1/screens/products_list.dart';
import 'package:cake_shop_app1/shared/states.dart';
import 'package:cake_shop_app1/viewModel/AddProductModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CakeShopCubit extends Cubit<CakeShopStates> {
  CakeShopCubit() : super(AddProductInitialStates());
  static CakeShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    ProductsListScreen(),
    AddProductsScreen(),
  ];
  AddProductModel? addProductModel;
  void addProduct({
    required String name,
    required String description,
    required String price,
  }) {
    AddProductModel addProductModel =
        AddProductModel(name: name, description: description, price: price);
    print("Loading....");
    emit(AddProductLoadingStates());
    FirebaseFirestore.instance
        .collection('add product')
        .doc()
        .set(addProductModel.toMap())
        .then((value) {
      AddProductModel addProductModel = AddProductModel.fromJson(json);

      emit(AddProductSuccessStates());
    }).catchError((error) {
      emit(AddProductErrorStates());
    });
  }

  ThemeMode? appMode = ThemeMode.dark;
  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppModeStates());
      {
        isDark = !isDark;
        CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
          emit(ChangeAppModeStates());
        });
      }
    }
  }
}
