class Contact {
  final int? id;
  final String name;
  final String phone;
  final String relation;

  Contact({
    this.id,
    required this.name,
    required this.phone,
    required this.relation,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      relation: json['relation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "phone": phone, "relation": relation};
  }
}
