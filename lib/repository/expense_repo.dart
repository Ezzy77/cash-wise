import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import '../model/expense.dart';

abstract class ExpenseRepo {
  Future<List<Expense>> getExpenses(String userId);
  Future<Expense?> getExpense(String expenseId);
  Future<void> addExpense(Expense expense);
  Future<void> updateExpense(Expense expense, String expenseId, String userId);
  Future<void> deleteExpense(String expenseId, String userId);
}


class ExpenseRepoImpl extends ExpenseRepo {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  @override
  Future<List<Expense>> getExpenses(String userId) async {
    try {
      final response = await _supabaseClient
          .from('expenses')
          .select('*')
          .eq('user_id', userId);
      final expenses = response.map((e) => Expense.fromMap(e)).toList();
      return expenses;
    } catch (e) {
      print('Get expenses error: $e');
      return [];
    }
  }

  @override
  Future<Expense?> getExpense(String expenseId) async {
    try {
      final response = await _supabaseClient
          .from('expenses')
          .select()
          .eq('expense_id', expenseId);

      return Expense.fromMap(response[0]);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> addExpense(Expense expense) async {
    await _supabaseClient
        .from('expenses')
        .upsert(expense.toMap());
  }

  @override
  Future<void> updateExpense(Expense expense, String expenseId, String userId) async {
    await _supabaseClient
        .from('expenses')
        .upsert(expense.toMap())
        .eq('expense_id', expenseId)
        .eq('user_id', userId);
  }

  @override
  Future<void> deleteExpense(String expenseId, String userId) async {
    await _supabaseClient
        .from('expenses')
        .delete()
        .eq('expense_id', expenseId)
        .eq('user_id', userId);
  }
}