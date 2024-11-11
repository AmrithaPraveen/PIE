class FoodModel {
  FoodModel({
    required this.name,
    required this.description,
    required this.location,
    required this.menu,
    required this.details,
    required this.id,
  });

  final String name;
  final String description;
  final String location;
  final String menu;
  final String details;
  final String id;

  factory FoodModel.fromJson(var json) {
    return FoodModel(
      name: json["Name"].toString() ?? "",
      description: json["Description"].toString() ?? "",
      location: json["Location"].toString() ?? "",
      menu: json["Menu"].toString() ?? "",
      details: json["Details"].toString() ?? "",
      id: json["id"].toString() ?? " ",
    );
  }

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Description": description,
        "Location": location,
        "Menu": menu,
        "Details": details,
      };

  @override
  String toString() {
    return "$name, $description, $location, $menu, $details,  ";
  }
}
