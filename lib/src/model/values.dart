// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:math';
import 'package:random_date/random_date.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

final places = [
  'CÔTE OUBLIÉE',
  'NOUMÉA',
];

final categories = [
  'Festival',
  'Concert',
  'Soirée',
  'Animation',
  'Exposition',
  'Spectacle',
  'Conférence',
  'Cinéma',
  'Gastronomie',
  'Sport',
  'Loisir',
  'Voyage'
];

final options = [
  'Seul',
  'En couple',
  'Animaux',
  'Enfant',
];

final _words = [
  'Bar',
  'Exposition',
  'Diner',
  'Fire',
  'Subculture',
  'Concert',
  'Place',
  'Best',
  'Spot',
  'Sortie en mer',
  'kanak',
  'Festival',
  'Mer',
  'Cafe',
  'Pop-up',
  'Soirée',
  'Blanche',
  'Snack',
  'BigFlo et Oli',
  'Marché',
  'Noel',
  'Bateau',
  'Brunch\'',
];

final _reviewTextPerRating = {
  1: [
    'Would never eat here again!',
    'Such an awful place!',
    'Not sure if they had a bad day off, but the food was very bad.'
  ],
  2: [
    'Not my cup of tea.',
    'Unlikely that we will ever come again.',
    'Quite bad, but I\'ve had worse!'
  ],
  3: [
    'Exactly okay :/',
    'Unimpressed, but not disappointed!',
    '3 estrellas y van que arden.'
  ],
  4: [
    'Actually pretty good, would recommend!',
    'I really like this place, I come quite often!',
    'A great experience, as usual!'
  ],
  5: [
    'This is my favorite place. Literally',
    'This place is ALWAYS great!',
    'I recommend this to all my friends and family!'
  ],
};

final random = Random();

String getRandomReviewText(int rating) {
  final reviews = _reviewTextPerRating[rating];
  return reviews[random.nextInt(reviews.length)];
}

String getRandomName() {
  final firstWord = random.nextInt(_words.length);
  var nextWord;
  do {
    nextWord = random.nextInt(_words.length);
  } while (firstWord == nextWord);
  return '${_words[firstWord]} ${_words[nextWord]}';
}

Timestamp getRandomTimpestamp() {
  return Timestamp.fromDate(RandomDate.withStartYear(2020).random());
}

String getRandomPlace() {
  return places[random.nextInt(places.length)];
}

String getRandomCategory() {
  return categories[random.nextInt(categories.length)];
}

String getRandomPhoto() {
  final photoId = random.nextInt(21) + 1;
  return 'https://storage.googleapis.com/firestorequickstarts.appspot.com/food_$photoId.png';
}
