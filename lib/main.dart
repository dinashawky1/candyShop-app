import 'package:cake_shop_app1/network/cacheHelper.dart';
import 'package:cake_shop_app1/screens/add_products.dart';
import 'package:cake_shop_app1/screens/products_list.dart';
import 'package:cake_shop_app1/shared/cubit.dart';
import 'package:cake_shop_app1/shared/states.dart';
import 'package:cake_shop_app1/shared/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Widget? widget;
  runApp(CakeShopApp(
    startWidget: widget!,
    isDark: false,
  ));
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  await Firebase.initializeApp();
}

class CakeShopApp extends StatelessWidget {
  final Widget startWidget;
  final bool isDark;

  CakeShopApp({required this.isDark, required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => CakeShopCubit()
            ..addProduct(description: '', name: '', price: '')),
        ),
        BlocProvider(
            create: (context) =>
                CakeShopCubit()..changeAppMode(fromShared: isDark)),
      ],
      child: BlocConsumer<CakeShopCubit, CakeShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: CakeShopCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: startWidget,
            );
          }),
    );
  }
}
