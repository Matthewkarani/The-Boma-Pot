#!/bin/bash

# Start the FastAPI application on localhost
uvicorn main:app --host 127.0.0.1 --port 8000 &

# Wait for a moment to ensure FastAPI has time to start
sleep 5

# Navigate to the Flutter app directory (if separate) and run the Flutter web server
# Replace 'your_flutter_app_directory' with the actual directory name
cd "C:\Users\ADMIN\Documents\Moringa\DSFT-09\Phase 4\dsc-phase-4-project\frontend\recipe_recommendation_front_end"

# Check if Flutter is installed and get dependencies
if command -v flutter &> /dev/null
then
    flutter pub get
    # Run the Flutter app on localhost
    flutter run -d web --host=127.0.0.1 --web-port=3000
else
    echo "Flutter is not installed. Please install Flutter to run the app."
    exit 1
fi
