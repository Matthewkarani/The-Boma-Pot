import 'package:flutter/material.dart';

class RecipeIntroCard extends StatelessWidget {
  final String title;

  const RecipeIntroCard({Key? key, required this.title}) : super(key: key);

  // Generate dynamic image URL based on title
  String getImageUrl(String title) {
    String formattedTitle = title.replaceAll(' ', '_').toLowerCase();
    return 'https://example.com/images/$formattedTitle.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe title
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Recipe image (use dynamic URL or placeholder)
            Image.network(
              getImageUrl(title),
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/images/placeholder_image.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
