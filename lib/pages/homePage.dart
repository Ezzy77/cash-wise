import 'package:cash_wise2/main.dart';
import 'package:cash_wise2/service/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 40, 49),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255,48, 55, 69),
        title: const Text('Welcome'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 5,
            decoration:  BoxDecoration(
              color:  const Color.fromARGB(255,48, 55, 69),
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
                        color: const Color.fromARGB(255, 255, 0, 0),
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Expenses",
                    style: TextStyle(color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    )
                ),
                Text("View All", style:
                TextStyle(color: Colors.grey,
                  fontSize: 10,
                )),
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
                    color: const Color.fromARGB(255,48, 55, 69),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align the children to the start
                      children: [
                        Text(
                          item['merchant'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold, // Add this line
                          ),
                        ),
                        Text(
                          DateFormat('MMM dd, yyyy').format(DateTime.parse(item['date'])),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12
                          ),
                        ),
                        // Add more widgets here if needed
                      ],
                    ), // Use the item data to build the list item
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.shopping_basket, color: Colors.white), // Replace with your desired color
                    ),
                    trailing: Text('£${item['amount']}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                      ),
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