import 'dart:convert';

class ItemEntity {
  int? id;
  String? title;
  String? description;
  String? createdAt;
  ItemEntity({
    this.id,
    this.title,
    this.description,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt,
    };
  }

  factory ItemEntity.fromMap(Map<String, dynamic> map) {
    return ItemEntity(
      id: map['id']?.toInt(),
      title: map['title'],
      description: map['description'],
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemEntity.fromJson(String source) => ItemEntity.fromMap(json.decode(source));
}
