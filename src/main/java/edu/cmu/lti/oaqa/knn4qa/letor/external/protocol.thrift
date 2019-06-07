namespace java edu.cmu.lti.oaqa.knn4qa.letor.external

struct WordEntryInfo {
  1: required string      word; // a word
  2: required double      IDF; // the value of the word IDF
}

struct TextEntryInfo {
  1: required string                id;
  2: required list<WordEntryInfo>   entries; 
}

exception ScoringException {
    1: string message;
}

service ExternalScorer {
  map<string, double> getScores(1: required TextEntryInfo         query, // a query entry
                                2: required list<TextEntryInfo>   docs) // an array of documents 
  throws (1: ScoringException err)
}