import 'package:flutter/material.dart';
import 'package:recipe_recommendation_front_end/pages/recipe_pages/recipe_detail_page.dart';
import 'package:recipe_recommendation_front_end/widgets/recipe_card.dart';

class RecipeListPage extends StatelessWidget {
  final String ingredients; // Field to hold the ingredients passed from GetRecipesPage
  final List<Map<String, dynamic>> recipes; // Field to hold the list of recipes

  // Constructor to accept ingredients and recipes from the previous page
  const RecipeListPage({
    Key? key,
    required this.ingredients,
    required this.recipes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Debug prints to check incoming data
    print('Ingredients: $ingredients');
    print('Recipes: $recipes');

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/RecipeListPage.png'),
                  fit: BoxFit.cover, // Ensures the image covers the entire screen
                ),
              ),
            ),
          ),

          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                // Non-editable text field for ingredients
                Padding(
                  padding: const EdgeInsets.only(top: 220.0), // 30px below the top
                  child: TextField(
                    controller: TextEditingController(text: "Your Ingredients: $ingredients"),
                    readOnly: true, // Make it non-editable
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black54, // Slightly transparent black background
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners
                        borderSide: BorderSide.none, // Remove the border
                      ),
                      hintText: 'Ingredients You Entered',
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),

                const SizedBox(height: 20), // Spacing below the text field

                // Display the list of recipes
                const Text(
                  'Recipes Based on Your Ingredients:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),

                const SizedBox(height: 10),

                // ListView to display recipes with RecipeCard
                Expanded(
                  child: recipes.isNotEmpty
                      ? ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return RecipeCard(
                        recipe: recipe ?? {}, // Safe access with a default value
                        onTap: () {
                          // Navigate to RecipeDetailPage when tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetailPage(recipe: recipe ?? {}),
                            ),
                          );
                        },
                      );
                    },
                  )
                      : const Center(
                    child: Text(
                      'No recipes found.',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
