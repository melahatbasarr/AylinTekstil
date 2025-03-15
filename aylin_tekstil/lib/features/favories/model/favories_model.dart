class FavoriHomeModel {
  final String id;
  final String name;
  final Map<String, String> colorImages;
  final String amount;
  final String group;
  final String description;
  final List<String> availableColors;
  String selectedColor;
  bool isFavorited;

  FavoriHomeModel({
    required this.id,
    required this.name,
    required this.colorImages,
    required this.amount,
    required this.group,
    required this.description,
    required this.availableColors,
    this.selectedColor = "Red",
    this.isFavorited = false,
  });
}
