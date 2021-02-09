class ProductModel {
  String id;
  String name;
  List<String> images;
  List<String> categories;
  String brand;
  String description;
  double price;

  ProductModel({
    this.id,
    this.name,
    this.images,
    this.description,
    this.categories,
    this.brand,
    this.price,
  });

  ProductModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        name = snapshot['name'] ?? '',
        images = snapshot['images'] ?? '',
        description = snapshot['description'] ?? '',
        price = snapshot['price'];

  toJson() {
    return Map<String, dynamic>.from({
      'id': this.id,
      'name': this.name,
      'images': this.images,
      'description': this.description,
      'categories': this.categories,
      'brand': this.brand,
      'price': this.price,
    });
  }
}
