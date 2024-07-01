class Budget{
  final String budgetId;
  final String userId;
  final String categoryId;
  final double amount;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;

  Budget({
    required this.budgetId,
    required this.userId,
    required this.categoryId,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
  });

  // Convert Budget to Map
  Map<String, dynamic> toMap() {
    return {
      'budgetId': budgetId,
      'userId': userId,
      'categoryId': categoryId,
      'amount': amount,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Convert Map to Budget
  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      budgetId: map['budgetId'],
      userId: map['userId'],
      categoryId: map['categoryId'],
      amount: map['amount'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}