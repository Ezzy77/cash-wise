import '../model/expense.dart';
import '../repository/expense_repo.dart';

class ExpenseService{
  final ExpenseRepo _expenseRepository = ExpenseRepoImpl();

  Future<List<Expense>> getExpenses(String userId) async {
    return _expenseRepository.getExpenses(userId);
  }

  Future<Expense?> getExpense(String expenseId) async {
    return _expenseRepository.getExpense(expenseId);
  }

  Future<void> addExpense(Expense expense) async {
    return _expenseRepository.addExpense(expense);
  }

  Future<void> updateExpense(Expense expense, String expenseId, String userId) async {
    return _expenseRepository.updateExpense(expense, expenseId, userId);
  }

  Future<void> deleteExpense(String expenseId, String userId) async {
    return _expenseRepository.deleteExpense(expenseId, userId);
  }


}