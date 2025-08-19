class Business {
  final String id;
  final String name;
  final String phone;
  final String description;
  final String? imagePath;
  final bool isSubscribed;
  final List<MenuItem> menuItems;

  Business({
    required this.id,
    required this.name,
    required this.phone,
    required this.description,
    this.imagePath,
    this.isSubscribed = false,
    this.menuItems = const [],
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      description: json['description'] ?? '',
      imagePath: json['imagePath'],
      isSubscribed: json['isSubscribed'] ?? false,
      menuItems: (json['menuItems'] as List<dynamic>?)
          ?.map((item) => MenuItem.fromJson(item))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'description': description,
      'imagePath': imagePath,
      'isSubscribed': isSubscribed,
      'menuItems': menuItems.map((item) => item.toJson()).toList(),
    };
  }

  Business copyWith({
    String? id,
    String? name,
    String? phone,
    String? description,
    String? imagePath,
    bool? isSubscribed,
    List<MenuItem>? menuItems,
  }) {
    return Business(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      menuItems: menuItems ?? this.menuItems,
    );
  }
}

class MenuItem {
  final String id;
  final String name;
  final double price;
  final String? imagePath;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    this.imagePath,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imagePath': imagePath,
    };
  }

  MenuItem copyWith({
    String? id,
    String? name,
    double? price,
    String? imagePath,
  }) {
    return MenuItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}

