# Define

A simple iOS app that looks up the definitions of words and saves them for later.
It can be used while, say, reading to learn about words that you may not have come across before.

# API
The API that provides the definiton of words is the [Oxford Languages API](https://developer.oxforddictionaries.com/).

## API Key
As the API key is private, a `dictionary-api-key.json` JSON file should be created in the project directory.
I.e. the directory containing the `.xcodeproj` file.

The JSON should be of the form:
```json
{
    "app_id": "<your-app-id>",
    "app_key": "<your-app-key>"
}
```
This file is not checked in to Git.
For now, this project should be run on a simulator.
