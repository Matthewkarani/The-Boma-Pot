import 'dart:convert';
import 'package:http/http.dart' as http;
class ImageSearchService {
  static const String apiKey = 'AIzaSyAfauPcGPBn0wUhG-SX-2PnNf3BXZCm400'; // Your Google API Key
  static const String cx = '71beb2296da41457e';   // Your Custom Search Engine ID

  // Function to fetch images from Google Search based on the title
  static Future<List<String>> fetchImages(String query) async {
    final String searchUrl = 'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=$cx&q=$query&searchType=image&num=2';

    try {
      final response = await http.get(Uri.parse(searchUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['items'] != null && data['items'].isNotEmpty) {
          // Get the first two image URLs
          return [
            data['items'][0]['link'],
            data['items'][1]['link'],
          ];
        } else {
          return ['assets/images/placeholder_image.png']; // Return placeholder if no images found
        }
      } else {
        throw Exception('Failed to load images');
      }
    } catch (e) {
      print(e);
      return ['assets/images/placeholder_image.png']; // Fallback to placeholder on error
    }
  }
}