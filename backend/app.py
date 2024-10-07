from flask import Flask, jsonify, request
from flask_cors import CORS

app = Flask(__name__)
CORS(app, resources={r"/api/*": {"origins": "*"}})  # This enables CORS for all routes

# Dample route. 
@app.route('/api/data',methods=['GET'])
def get_data():
    sample_data = {
        "message": "Hello from Nairobi,Kenya!", 
        "items":[1,2,3,4,5]
    }
    return jsonify(sample_data)

if __name__ == '__main__':
    app.run(debug=True)