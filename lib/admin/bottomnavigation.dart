import 'package:bill/admin/home.dart';
import 'package:bill/admin/receipt_view.dart';
import 'package:flutter/material.dart';
import 'customers.dart';

class BottomNavigation extends StatefulWidget {
  final int initialIndex; 

  const BottomNavigation({super.key, required this.initialIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int currentIndex; // Initialize currentIndex later

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex; // Initialize with the passed index
  }

  // List of screens to navigate between
  final List<Widget> screens = [
    Home(), // Home screen (import from admin/home.dart)
    Customers(), // Customers screen
    ViewReceipt(), // Placeholder for Receipts screen
    Center(child: Text("More")), // Placeholder for More screen
  ];

  // Method to update the current index on tab tap
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index; // Update the current index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex], // Display the selected screen

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex, // Set the current index
        onTap: onTabTapped, // Handle tab taps
        type: BottomNavigationBarType.fixed, // Prevents animation when adding more than 3 items
        items: [
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: currentIndex == 0 ? Colors.blue.withOpacity(0.1) : Colors.transparent,
              ),
              height: 30,
              width: 50,
              child: Icon(Icons.home_outlined),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: currentIndex == 1 ? Colors.blue.withOpacity(0.1) : Colors.transparent,
              ),
              height: 30,
              width: 50,
              child: Icon(Icons.people_alt_outlined),
            ),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Circular effect
                color: currentIndex == 2 ? Colors.blue.withOpacity(0.1) : Colors.transparent, // Apply overlay when selected
              ),
              padding: EdgeInsets.all(5), // Padding to center the image inside the container
              height: 30,
              width: 50,
              child: Image(
                image: AssetImage("assets/rupee-.png"),
                height: 25,
                color: currentIndex == 2 ? Colors.blue.shade800 : Colors.grey, // Change color based on selection
              ),
            ),
            label: 'Receipts',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Circular effect
                color: currentIndex == 3 ? Colors.blue.withOpacity(0.1) : Colors.transparent, // Apply overlay when selected
              ),
              padding: EdgeInsets.all(5), // Padding to center the image inside the container
              height: 30,
              width: 50,
              child: Image(
                image: AssetImage("assets/mor.png"),
                height: 30,
                color: currentIndex == 3 ? Colors.blue.shade800 : Colors.grey, // Change color based on selection
              ),
            ),
            label: 'More',
          ),
        ],
        selectedItemColor: Colors.blue.shade800, // Color of the selected item
        unselectedItemColor: Colors.grey, // Color of unselected items
        showUnselectedLabels: true, // Show labels for unselected items
      ),
    );
  }
}
