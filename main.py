#import the necessary libraries
from fastapi import FastAPI, HTTPException
import joblib
import pandas as pd
from recipe_recommender import recommend_recipes, clean_input


#initialize the FastAPI
app = FastAPI()

#Load the files
#the tf-idf vectorizer
with open('tfidf_vectorizer.pkl','rb') as f:
    tfidf_vectorizer = joblib.load(f)

#matrix pickle
with open('tfidf_matrix.pkl','rb') as f:
    tfidf_matrix = joblib.load(f)

#cosine simialrity 
with open('cosine_sim.pkl','rb') as f:
    cosine_sim = joblib.load(f)

#combined df
df = pd.read_csv('combined_df.csv')

@app.get("/")
def read_root():
    return{"mesaage":"Welcome to the Recipe Recommendation API!"}

@app.post("/recommend")
def get_recommendation(ingredients: str):
    try:
        #clean the input 
        cleaned_input = clean_input(ingredients)

        #get recommendations using the recommend recipe
        recommended_recipes = recommend_recipes(cleaned_input, df, cosine_sim, tfidf_vectorizer)
        if isinstance(recommended_recipes, str):
            return {"message": recommended_recipes}
        
        # Return recommended recipes as JSON
        return recommended_recipes.to_dict(orient='records')
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")


