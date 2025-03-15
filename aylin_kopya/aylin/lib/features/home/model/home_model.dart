class HomeModel {
  final String id;
  final String name;
  final Map<String, String> colorImages;
  final String amount;
  final String group;
  final String description;
  final List<String> availableColors;
  String selectedColor;
  bool isFavorited;

  HomeModel({
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

  HomeModel copyWith({
    String? id,
    String? name,
    Map<String, String>? colorImages,
    String? amount,
    String? group,
    String? description,
    List<String>? availableColors,
    String? selectedColor,
    bool? isFavorited,
  }) {
    return HomeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      colorImages: colorImages ?? this.colorImages,
      amount: amount ?? this.amount,
      group: group ?? this.group,
      description: description ?? this.description,
      availableColors: availableColors ?? this.availableColors,
      selectedColor: selectedColor ?? this.selectedColor,
      isFavorited: isFavorited ?? this.isFavorited,
    );
  }
}
