import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_recommendation_front_end/services/image_search_service.dart';

class RecipeDetailPage extends StatefulWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  List<String> _imageUrls = []; // Store the fetched image URLs
  bool _isLoading = true; // Track the loading state

  @override
  void initState() {
    super.initState();
    _fetchRecipeImages();
  }

  // Function to fetch images based on the recipe title
  Future<void> _fetchRecipeImages() async {
    final recipeTitle = widget.recipe['Title'] ?? 'Unknown Recipe';

    // Fetch images using the ImageSearchService
    List<String> images = await ImageSearchService.fetchImages(recipeTitle);

    // Update the state with the fetched images
    setState(() {
      _imageUrls = images;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String recipeTitle = widget.recipe['Title'] ?? 'Unknown Recipe';

    return Scaffold(
      body: Stack(
        children: [
          // Use the provided background image
          SizedBox.expand(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/SingleRecipePage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Use a SingleChildScrollView to avoid overflow
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Recipe Title
                  Text(
                    recipeTitle,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Display the fetched image or placeholder image below the title
                  _isLoading
                      ? const CircularProgressIndicator()
                      : _imageUrls.isNotEmpty
                      ? Image.network(
                    _imageUrls[0], // Display the first image
                    width: 300, // Fixed size for the image
                    height: 200,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      print('Error loading image: ${error.toString()}'); // Log the error details
                      return Image.asset(
                        'assets/images/placeholder_image.png',
                        width: 300,
                        height: 200,
                      );
                    },
                  )
                      : Image.asset(
                    'assets/images/placeholder_image.png',
                    width: 300,
                    height: 200,
                  ),

                  const SizedBox(height: 20),

                  // Ingredients Section
                  const Text(
                    'Ingredients:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildIngredients(widget.recipe['Ingredients']),

                  const SizedBox(height: 16),

                  // Preparation Steps Section
                  const Text(
                    'Preparation Steps:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildPreparationSteps(widget.recipe['Instructions']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build Ingredients Widget
  Widget _buildIngredients(dynamic ingredients) {
    // Check if ingredients are in a List
    if (ingredients is List && ingredients.isNotEmpty) {
      // Create a Text widget for each ingredient with numbering
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: ingredients.asMap().entries.map((entry) {
          int index = entry.key + 1; // Add 1 to start numbering from 1
          String ingredient = entry.value.toString().trim(); // Trim whitespace
          return Text('$index. $ingredient', style: const TextStyle(color: Colors.white)); // White text
        }).toList(),
      );
    } else if (ingredients is String && ingredients.isNotEmpty) {
      // Handle the case where ingredients is a string
      List<String> ingredientList = ingredients.split(',').map((ingredient) => ingredient.trim()).toList();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: ingredientList.asMap().entries.map((entry) {
          int index = entry.key + 1; // Add 1 to start numbering from 1
          return Text('$index. ${entry.value}', style: const TextStyle(color: Colors.white)); // White text
        }).toList(),
      );
    }

    return const Text('No ingredients available.', style: TextStyle(color: Colors.white)); // Message if no ingredients
  }

  // Build Preparation Steps Widget
  Widget _buildPreparationSteps(dynamic steps) {
    if (steps == null || (steps is String && steps.isEmpty)) {
      return const Text('No preparation steps available.', style: TextStyle(color: Colors.white)); // White text
    }

    // If steps is a single string, split it into sentences
    if (steps is String) {
      // Split the string into sentences using full stops as delimiters
      List<String> instructionsList = steps.split('. ').map((s) => s.trim()).toList();
      // Filter out empty strings
      instructionsList.removeWhere((s) => s.isEmpty);

      // Create a list of Text widgets for each instruction with numbering
      List<Widget> instructionWidgets = instructionsList.asMap().entries.map((entry) {
        int index = entry.key + 1; // Get the index (starting from 1)
        String instruction = entry.value; // Get the instruction
        return Text('$index. $instruction', style: const TextStyle(color: Colors.white)); // White text with numbering
      }).toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: instructionWidgets, // Display each instruction as a separate Text widget
      );
    }

    // If steps is neither a String nor null
    return const Text('Invalid preparation steps format.', style: TextStyle(color: Colors.white)); // White text
  }
}
