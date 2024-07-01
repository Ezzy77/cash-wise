class Transaction{
  final String id;
  final String userId;
  final DateTime date;
  final double amount;
  final String description;
  final String categoryId;
  final bool isReconciled;

  Transaction({
    required this.id,
    required this.userId,
    required this.date,
    required this.amount,
    required this.description,
    required this.categoryId,
    required this.isReconciled,
  });

  // Convert Transaction to Map
  Map<String, dynamic> toMap() {
    return {
      'transactionId': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'amount': amount,
      'description': description,
      'categoryId': categoryId,
      'isReconciled': isReconciled,
    };
  }

  // Convert Map to Transaction
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['transactionId'],
      userId: map['userId'],
      date: DateTime.parse(map['date']),
      amount: map['amount'],
      description: map['description'],
      categoryId: map['categoryId'],
      isReconciled: map['isReconciled'],
    );
  }
}