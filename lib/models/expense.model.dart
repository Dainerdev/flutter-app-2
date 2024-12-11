class Expense {
  final int id;
  final String name;
  final double amount;
  final String description;

  Expense({
    required this.id,
    required this.name,
    required this.amount,
    required this.description
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'], 
      name: json['name'], 
      amount: (json['amount'] ?? 0).toDouble(), 
      description: json['description'] ?? ''
    );
  }
}