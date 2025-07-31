import '../constants/enums/exception_enums.dart';
import '../error_handling/custom_exception.dart';

List<ProductModel> productListFromJson(List<dynamic> str) =>
    List<ProductModel>.from(str.map((dynamic x) => ProductModel.fromJson(x)));

class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.image,
    this.description,
    this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    try {
      return ProductModel(
          id: json['id'],
          name: json["name"],
          description: json["description"],
          price: json["price"],
          image: json["image"]);
    } catch (ex) {
      throw CustomException(CustomStatusCodeErrorType.parsing,
          errorMassage: "ProductModel error in Parsing: $ex");
    }
  }

  int? id;
  String? name;
  String? description;
  String? image;
  num? price;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id.toString(),
        "name": name,
        "description": description,
        "image": image,
      };
}
