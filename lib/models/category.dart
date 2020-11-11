class CategoryModel {
  final String name;
  final String description;
  final String image;
  final String id;

  CategoryModel({this.name, this.description, this.image, this.id});

  toJson() {
    return Map<String, dynamic>.from({
      'name': this.name,
      'description': this.description,
      'image': this.image,
      'id': this.id,
    });
  }
}
