
class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String category;

  ProductModel({
  required this.id,
  required this.name,
  required this.description,
  required this.price,
  required this.image,
  required this.category,
});

  factory ProductModel.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return ProductModel(
  id: id,
  name: map['name'] ?? '',
  description: map['description'] ?? '',
  price: (map['price'] ?? 0).toDouble(),
  image: map['image'] ?? '',
  category: map['category'] ?? '',
);
  }

  Map<String, dynamic> toMap() {
    return {
  'name': name,
  'description': description,
  'price': price,
  'image': image,
  'category': category,
};
  }
}