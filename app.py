from flask import Flask, request, jsonify
from flask_cors import CORS  # Added CORS extension

import joblib
import pandas as pd
from recipe_recommender import recommend_recipes, clean_input

# Initialize the Flask app
app = Flask(__name__)

# Enable CORS for all origins (adjust for specific origins if needed)
CORS(app)

# Load the files outside of route definitions
# (Pre-loading is generally recommended for performance)
tfidf_vectorizer = joblib.load('tfidf_vectorizer.pkl')
tfidf_matrix = joblib.load('tfidf_matrix.pkl')
df = pd.read_csv('combined_df.csv')

@app.route("/", methods=["GET"])
def read_root():
    """Returns a welcome message for the API."""
    return jsonify({"message": "Welcome to the Recipe Recommendation API!"})

@app.route("/recommend", methods=["POST"])
def get_recommendation():
    """Recommends recipes based on provided ingredients, returning only 10 results."""
    try:
        # Get ingredients from request body
        ingredients = request.json.get("ingredients")
        if not ingredients:
            return jsonify({"message": "Missing 'ingredients' field in request body"}), 400

        # Clean the input
        cleaned_input = clean_input(ingredients)

        # Get recommendations
        recommended_recipes = recommend_recipes(cleaned_input, df, tfidf_matrix, tfidf_vectorizer)

        # Handle error from the recommendation function (if applicable)
        if isinstance(recommended_recipes, str):
            # Provide more specific error message if possible
            return jsonify({"message": f"Error: {recommended_recipes}"}), 400  # Or another appropriate status code

        # Limit recommendations to top 10
        top_10_recipes = recommended_recipes.head(10)

        # Return top 10 recipes in JSON format
        return jsonify(top_10_recipes.to_dict(orient='records'))

    except Exception as e:
        # Handle any other exceptions
        return jsonify({"message": f"An error occurred: {str(e)}"}), 500
    
if __name__ == "__main__":
    app.run(debug=True)