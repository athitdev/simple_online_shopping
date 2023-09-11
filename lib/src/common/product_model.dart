class ProductModel {
  int? id;
  String? name;
  String? imageUrl;
  int? number;
  double? price;

  ProductModel({this.id, this.name, this.imageUrl, this.price});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    number = json['number'];
    price = json['price'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['image_url'] = this.imageUrl;
  //   data['number'] = this.number;
  //   data['price'] = this.price;
  //   return data;
  // }
}
