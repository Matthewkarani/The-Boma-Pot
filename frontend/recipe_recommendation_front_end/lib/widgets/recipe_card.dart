import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final Map<String, dynamic> recipe;
  final VoidCallback onTap;

  const RecipeCard({Key? key, required this.recipe, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white, // White background
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Container(
          height: 220, // Increased card height to 220 pixels
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row( // Change to Row for horizontal alignment
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the image using the ImageService
                _buildRecipeImage(recipe['imageUrl']), // Assuming 'imageUrl' holds the fetched image URL
                const SizedBox(width: 16), // Space between image and text
                Expanded( // Expand the text section to fill remaining space
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display the recipe title
                      Text(
                        recipe['Title'] ?? 'Unknown Recipe',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black), // Black text
                      ),
                      const SizedBox(height: 8),
                      const Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)), // Black text
                      const SizedBox(height: 8),
                      // Display ingredients as a single continuous text
                      _buildIngredients(recipe['Ingredients']),
                      const SizedBox(height: 8),
                      const Text('Preparation Steps:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)), // Black text
                      const SizedBox(height: 8),
                      // Display preparation steps as a single continuous text
                      _buildPreparationSteps(recipe['Instructions']),
                      const SizedBox(height: 16), // Space before 'Read more'
                      const Text(
                        'Read more',
                        style: TextStyle(
                          color: Colors.blue, // Color for the "Read more" text
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to build and display the recipe image
  Widget _buildRecipeImage(String? imageUrl) {
    return Container(
      width: 70, // Width of the image
      height: 70, // Height of the image
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: imageUrl != null && imageUrl.isNotEmpty
            ? DecorationImage(
          image: NetworkImage(imageUrl), // Fetch the image from the network
          fit: BoxFit.cover,
        )
            : DecorationImage(
          image: AssetImage('assets/images/placeholder_image.png'), // Placeholder image
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Display ingredients as a single continuous text
  Widget _buildIngredients(dynamic ingredients) {
    String ingredientsText = '';

    if (ingredients is List && ingredients.isNotEmpty) {
      // Combine ingredients into a single sentence
      ingredientsText = ingredients.join(', ');
    } else if (ingredients is String && ingredients.isNotEmpty) {
      ingredientsText = ingredients;
    } else {
      ingredientsText = 'No ingredients available.'; // Message if no ingredients
    }

    return Text(
      ingredientsText,
      style: const TextStyle(color: Colors.black),
      maxLines: 1, // Ensure only one line
      overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
    );
  }

  // Display preparation steps as a single continuous text
  Widget _buildPreparationSteps(dynamic steps) {
    String stepsText = '';

    if (steps == null || (steps is String && steps.isEmpty)) {
      stepsText = 'No preparation steps available.'; // Message if no steps
    } else if (steps is String) {
      stepsText = steps;
    } else {
      stepsText = 'Invalid preparation steps format.'; // If steps is neither a String nor null
    }

    return Text(
      stepsText,
      style: const TextStyle(color: Colors.black),
      maxLines: 1, // Ensure only one line
      overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
    );
  }
}
