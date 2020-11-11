class BrandModel {
  final String name;
  final String description;
  final String image;
  final String id;

  BrandModel({this.name, this.description, this.image, this.id});

  toJson() {
    return Map<String, dynamic>.from({
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'image': this.image,
    });
  }
}
