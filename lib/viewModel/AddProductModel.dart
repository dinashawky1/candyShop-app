class AddProductModel {
  String? name;
  String? description;
  String? price;

  AddProductModel({
    required this.name,
    required this.description,
    required this.price,
  });

  AddProductModel.fromJson(json) {
    name = json['name'];
    description = json['description'];
    price = json['price'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
    };
  }
}
