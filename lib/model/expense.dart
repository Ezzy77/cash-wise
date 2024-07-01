class Expense {
  final String expenseId;
  final String userId;
  final DateTime date;
  final String merchant;
  final double amount;
  final String category;
  final String paymentMethod;
  final String? notes;

  Expense({
    required this.expenseId,
    required this.userId,
    required this.date,
    required this.merchant,
    required this.amount,
    required this.category,
    required this.paymentMethod,
    required this.notes,
  });

  // Convert Expense to Map
  Map<String, dynamic> toMap() {
    return {
      'expenseId': expenseId,
      'userId': userId,
      'date': date.toIso8601String(),
      'merchant': merchant,
      'amount': amount,
      'category': category,
      'paymentMethod': paymentMethod,
      'notes': notes,
    };
  }

  // Convert Map to Expense
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      expenseId: map['expenseId'] ?? 'Unknown Expense ID',
      userId: map['userId'] ?? 'Unknown User ID',
      date: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(),
      merchant: map['merchant'] ?? 'Unknown Merchant',
      amount: map['amount'] ?? 0.0,
      category: map['category'] ?? 'Unknown Category',
      paymentMethod: map['paymentMethod'] ?? 'Unknown Payment Method',
      notes: map['notes'] ?? 'No Notes',
    );
  }
}