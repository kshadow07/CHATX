class ImageUrl {
  final String? imageurl;

  ImageUrl(this.imageurl);

  Map<String, dynamic> toMap() {
    return {'images': imageurl};
  }
}
