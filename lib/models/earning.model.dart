class Earning {
  final int id;
  final String name;
  final double amount;
  final String description;

  Earning({
    required this.id,
    required this.name,
    required this.amount,
    required this.description
  });

  factory Earning.fromJson(Map<String, dynamic> json) {
    return Earning(
      id: json['id'], 
      name: json['name'], 
      amount: (json['amount'] ?? 0).toDouble(), 
      description: json['description'] ?? ''
    );
  }
}