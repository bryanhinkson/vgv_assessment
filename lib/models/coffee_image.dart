class CoffeeImage {
  final String imageUrl;

  const CoffeeImage({
    required this.imageUrl,
  });

  factory CoffeeImage.fromJson(Map<String, dynamic> json) {
    return CoffeeImage(
      imageUrl: json['file'],
    );
  }
}
