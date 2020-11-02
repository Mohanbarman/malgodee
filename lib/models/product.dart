class Product {
  String id;
  String name;
  String img;
  String description;
  List highlights;

  Product({this.id, this.name, this.img, this.description, this.highlights});

  Product.fromMap(Map snapshot, String id)
      : id = id ?? '',
        name = snapshot['name'] ?? '',
        img = snapshot['img'] ?? '',
        description = snapshot['description'] ?? '',
        highlights = snapshot['highlights'].split('\n') ?? '';

  toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'img': this.img,
      'description': this.description,
      'highlights': this.highlights,
    };
  }
}
