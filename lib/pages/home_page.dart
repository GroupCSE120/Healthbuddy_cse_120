import 'package:flutter/material.dart';
import 'package:health_buddy/components/home.dart';
import 'package:health_buddy/constants/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppColors colors = AppColors(); // Access the color palette
  int _selectedIndex = 1; // Default selected index (Home)

  final List<Widget> _pages = [
    Center(child: Text("Health Tips", style: TextStyle(color: Colors.white))),
    Home(),
    Center(child: Text("Diet Plans", style: TextStyle(color: Colors.white))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.darkBg,
      appBar: AppBar(
        backgroundColor: colors.darkBg,
        title: Text(
          "Health Buddy",
          style: TextStyle(color: colors.lightBlue),
        ),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: colors.darkBlue,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, -3),
              blurRadius: 6,
            )
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          currentIndex: _selectedIndex,
          selectedItemColor: colors.lightBlue,
          unselectedItemColor: Colors.white.withOpacity(0.7),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            _buildBarItem(
              icon: Icons.local_hospital,
              label: 'Health Tips',
              isSelected: _selectedIndex == 0,
            ),
            _buildBarItem(
              icon: Icons.home,
              label: 'Home',
              isSelected: _selectedIndex == 1,
            ),
            _buildBarItem(
              icon: Icons.restaurant,
              label: 'Diet Plans',
              isSelected: _selectedIndex == 2,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBarItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: isSelected ? const EdgeInsets.all(6) : EdgeInsets.zero,
        decoration: isSelected
            ? BoxDecoration(
          color: colors.lightBlue.withOpacity(0.2),
          shape: BoxShape.circle,
        )
            : null,
        child: Icon(icon),
      ),
      label: label,
    );
  }
}
