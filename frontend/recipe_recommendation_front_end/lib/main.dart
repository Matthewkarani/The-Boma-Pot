import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(), // Start with LandingPage
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Full-page background image using SizedBox
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/landingPage.png'),
                  fit: BoxFit.cover, // Ensures the image covers the entire screen
                ),
              ),
            ),
          ),
          // Centered content with the button
          Positioned(
            left: screenSize.width * 0.05, // Adjusted left property to move right
            bottom: screenSize.height * 0.15, // Position just above the bottom
            width: screenSize.width * 0.4, // Occupy the left half of the screen
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Add padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end, // Align to the bottom of the column
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Discover Recipes Button
                  Container(
                    margin: const EdgeInsets.only(top: 10), // Margin around the button
                    child: Material(
                      elevation: 5, // Add elevation for shadow effect
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                      child: SizedBox(
                        width: double.infinity, // Set button width to fill its container
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to RecipesPage with smooth transition
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => RecipesPage(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0); // Start from the right
                                  const end = Offset.zero; // End at the center
                                  const curve = Curves.easeInOut;

                                  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                  final offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFF00c4cc), // Button color
                            padding: EdgeInsets.symmetric(vertical: 20), // Vertical padding
                          ),
                          child: const Text(
                            'Discover Recipes',
                            style: TextStyle(
                              fontSize: 20, // Enlarged text size
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecipesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Full-page background image using SizedBox
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/addIngredientsPage.png'),
                  fit: BoxFit.cover, // Ensures the image covers the entire screen
                ),
              ),
            ),
          ),
          // Centered content with input box and search button
          Positioned(
            left: screenSize.width * 0.05, // Align to the left
            bottom: screenSize.height * 0.15, // Position just above the home icon
            width: screenSize.width * 0.4, // Occupy the left half of the screen
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Add padding to the left half
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end, // Align to the bottom of the column
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Get ready to excite your taste buds!',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16), // Spacing between text and input box
                  // Input Box with contrasting hint text color
                  Container(
                    width: double.infinity, // Set input box width to fill its container
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2), // White border
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    child: TextField(
                      style: const TextStyle(color: Colors.white), // Change text color to white
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Please enter your ingredients here',
                        hintStyle: TextStyle(color: Color(0xFFFFD700)), // Light beige color for hint text
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15), // Padding for the input
                      ),
                    ),
                  ),
                  const SizedBox(height: 16), // Spacing between input box and button
                  Container(
                    margin: const EdgeInsets.only(top: 10), // Margin around the button
                    child: Material(
                      elevation: 5, // Add elevation for a shadow effect
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                      child: SizedBox(
                        width: double.infinity, // Set button width to fill its container
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle search action
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Searching for recipes...'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFF00c4cc), // Button color
                            padding: EdgeInsets.symmetric(vertical: 20), // Vertical padding
                          ),
                          child: const Text(
                            'Search',
                            style: TextStyle(
                              fontSize: 20, // Enlarged text size
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Positioned Home Icon
          Positioned(
            bottom: screenSize.height * 0.05, // Adjust the distance from the bottom
            left: screenSize.width * 0.05, // Align to the left to match other elements
            child: GestureDetector(
              onTap: () {
                // Navigate back to the LandingPage with smooth transition
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal, // Background color for the icon
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12), // Padding around the icon
                child: const Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 30, // Icon size
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
