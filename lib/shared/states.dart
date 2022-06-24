abstract class CakeShopStates {}

class AddProductInitialStates extends CakeShopStates {}

class AddProductLoadingStates extends CakeShopStates {}

class AddProductSuccessStates extends CakeShopStates {
  var addProductModel;
}

class AddProductErrorStates extends CakeShopStates {}

class ChangeAppModeStates extends CakeShopStates {}
