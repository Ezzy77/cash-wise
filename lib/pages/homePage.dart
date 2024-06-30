import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Define your list of items
  final List<Map<String, dynamic>> items = [
    {'title': 'Food', 'icon': Icons.fastfood},
    {'title': 'Transport', 'icon': Icons.directions_car},
    {'title': 'Shopping', 'icon': Icons.shopping_cart},
    {'title': 'Entertainment', 'icon': Icons.movie},
    {'title': 'Bills', 'icon': Icons.receipt},
    {'title': 'Others', 'icon': Icons.more_horiz},
    // Add more items as needed
  ];

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
          ),
          Container(
            margin: const EdgeInsets.all(20), // Set the margin as per your requirement
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Transactions",
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
                    title: Text(item['title']), // Use the item data to build the list item
                    leading: Icon(item['icon']),
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