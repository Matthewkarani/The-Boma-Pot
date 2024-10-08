import re
from sklearn.metrics.pairwise import cosine_similarity


def clean_input(title):
    """Normalize titles by removing punctuation, converting to lowercase, and stripping extra spaces."""
    title = re.sub(r'[^\w\s]', '', title)
    title = re.sub(r'\s+', ' ', title).strip().lower()
    return title

# Function to recommend recipes
def recommend_recipes(user_input, combined_df, tfidf_vectorizer, tfidf_matrix, n=10):
    """
    Recommend recipes based on user input.
    
    Parameters:
    - user_input (str): The user input to search for recipes.
    - combined_df (DataFrame): DataFrame containing recipe data.
    - tfidf_vectorizer (TfidfVectorizer): The fitted TF-IDF vectorizer.
    - tfidf_matrix (array): The TF-IDF matrix of the recipes.
    - n (int): Number of recommendations to return.
    
    Returns:
    - DataFrame: Top n recommended recipes or a message if no match is found.
    """
    
    # Clean the user input
    user_input_cleaned = clean_input(user_input)
    
    # Check if the user input matches a specific title
    matching_title = combined_df[combined_df['Title'].str.lower().str.contains(user_input_cleaned)]
    
    # Check if there is a match by title
    if not matching_title.empty:
        return matching_title[['Title', 'Ingredients', 'Instructions']]
    
    # If no exact title match is found, proceed with TF-IDF based recommendation
    # Transform the user input
    user_input_transformed = tfidf_vectorizer.transform([user_input_cleaned])
    
    # Compute the cosine similarity between the user input and the recipes
    cosine_sim = cosine_similarity(user_input_transformed, tfidf_matrix)
    
    # Get the index of the top n most similar recipes
    similar_recipes = cosine_sim[0].argsort()[-n:][::-1]
    
    # Check if any similar recipes were found
    if cosine_sim[0].max() == 0:  # If maximum similarity is 0, meaning no match found
        return "No similar recipes found."
    
    # Return the top n most similar recipes
    return combined_df.iloc[similar_recipes][['Title', 'Ingredients', 'Instructions']]
