class BrandModel {
  final String name;
  final String description;
  final String image;

  BrandModel({this.name, this.description, this.image});

  toJson() {
    return Map<String, dynamic>.from({
      'name': this.name,
      'description': this.description,
      'image': this.image,
    });
  }
}
