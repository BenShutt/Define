# Define

An iOS app used to search for the definitions of words and save them for later.
It may be used while, say, reading to learn and remember new words.

## Dictionary API

The API that provides the definitons of words is the (free) [Dictionary API](https://dictionaryapi.dev/).

Example searching with language "en" for the word "define":
```txt
https://api.dictionaryapi.dev/api/v2/entries/en/define
```

Link to [Dictionary API Github Repository](https://github.com/meetDeveloper/freeDictionaryAPI).

### Oxford Dictionary API

The project previously used the [Oxford Languages API](https://developer.oxforddictionaries.com/).
It was removed due to usage limitations. 
Also, an API key (and thus `dictionary-api-key.json` JSON file) is no longer needed so the new approach is simpler.
This implementation can be found in the Git history.

## Motivation

Primarily created to learn more about SwiftUI having nearly always developed with UIKit.
But also creates a neat little helpful tool.
