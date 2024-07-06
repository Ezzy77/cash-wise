import 'package:cash_wise2/main.dart';
import 'package:cash_wise2/service/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ExpenseService _expenseService = ExpenseService();

  final user = supabase.auth.currentUser;

  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    try {
      final data = await _expenseService.getExpenses(user!.id);
      setState(() {
        items = data.map((e) => e.toMap()).toList();
      });
    } catch (e) {
      print('Get expenses error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title:  Text('Welcome', style: theme.textTheme.bodyLarge),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 5,
            decoration:  BoxDecoration(
              color:  theme.cardColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: SizedBox(
                height: 125, // Adjust these values to change the size of the chart
                width: 125, // Adjust these values to change the size of the chart
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        color: const Color.fromARGB(255, 48, 45, 59),
                        value: 10,
                        title: '30%',
                        radius: 40,
                        titleStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        color: const Color.fromARGB(255, 255, 185, 0),
                        value: 20,
                        title: '20%',
                        radius: 40,
                        titleStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        color: const Color.fromARGB(200,16, 44, 87),
                        value: 50,
                        title: '50%',
                        radius: 40,
                        titleStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20), // Set the margin as per your requirement
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Expenses",
                  style: theme.textTheme.bodyLarge,
                ),
                Text("View All",
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length, // Set the item count to the length of your list
              itemBuilder: (context, index) {
                // Access the item data using the index
                final item = items[index];

                return Container(
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align the children to the start
                      children: [
                        Text(
                          item['merchant'],
                          style: theme.textTheme.bodyLarge,
                        ),
                        Text(
                          DateFormat('MMM dd, yyyy').format(DateTime.parse(item['date'])),
                          style: theme.textTheme.bodySmall,
                        ),
                        // Add more widgets here if needed
                      ],
                    ), // Use the item data to build the list item
                    leading:  CircleAvatar(
                      backgroundColor: theme.iconTheme.color,
                      child: const Icon(Icons.shopping_basket, color: Colors.white), // Replace with your desired color
                    ),
                    trailing: Text('£${item['amount']}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    onTap: () {
                      // Handle tap
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}