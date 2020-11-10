class CategoryModel {
  final String name;
  final String description;
  final String image;

  CategoryModel({this.name, this.description, this.image});

  toJson() {
    return Map<String, dynamic>.from({
      'name': this.name,
      'description': this.description,
      'image': this.image,
    });
  }
}
