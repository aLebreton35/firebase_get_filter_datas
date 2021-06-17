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

import 'package:cloud_firestore/cloud_firestore.dart';

import './filter.dart';
import './event.dart';
import './review.dart';

// This is the file that Codelab users will primarily work on.

Future<void> addEvent(Event event) {
  final events = FirebaseFirestore.instance.collection('events');
  return events.add({
    'description': event.description,
    'eventDateBegin': event.eventDateBegin,
    'eventDateEnd': event.eventDateEnd,
    'name': event.name,
    'image': event.image,
    'location': event.location,
    'organizer': event.organizer,
    'category': event.category,
    'place': event.place,
    'price': event.price,
  });
}

Stream<QuerySnapshot> loadAllEvents() {
  return FirebaseFirestore.instance
      .collection('events')
      // .orderBy('eventDateBegin', descending: true)
      .limit(50)
      .snapshots();
}

List<Event> getEventsFromQuery(QuerySnapshot snapshot) {
  return snapshot.docs.map((DocumentSnapshot doc) {
    return Event.fromSnapshot(doc);
  }).toList();
}

Future<Event> getEvent(String eventId) {
  return FirebaseFirestore.instance
      .collection('events')
      .doc(eventId)
      .get()
      .then((DocumentSnapshot doc) => Event.fromSnapshot(doc));
}

// Future<void> addReview({String eventId, Review review}) {
//   final event =
//       FirebaseFirestore.instance.collection('events').doc(eventId);
//   final newReview = event.collection('ratings').doc();
//
//   return FirebaseFirestore.instance.runTransaction((Transaction transaction) {
//     return transaction
//         .get(event)
//         .then((DocumentSnapshot doc) => Event.fromSnapshot(doc))
//         .then((Event fresh) {
//       final newRatings = fresh.numRatings + 1;
//       final newAverage =
//           ((fresh.numRatings * fresh.avgRating) + review.rating) / newRatings;
//
//       transaction.update(event, {
//         'numRatings': newRatings,
//         'avgRating': newAverage,
//       });
//
//       transaction.set(newReview, {
//         'rating': review.rating,
//         'text': review.text,
//         'userName': review.userName,
//         'timestamp': review.timestamp ?? FieldValue.serverTimestamp(),
//         'userId': review.userId,
//       });
//     });
//   });
// }

Stream<QuerySnapshot> loadFilteredEvents(Filter filter) {
  Query collection = FirebaseFirestore.instance.collection('events');
  if (filter.category != null) {
    collection = collection.where('category', isEqualTo: filter.category);
  }
  if (filter.place != null) {
    collection = collection.where('place', isEqualTo: filter.place);
  }
  if (filter.price != null) {
    collection = collection.where('price', isEqualTo: filter.price);
  }
  return collection
      .orderBy(filter.sort ?? 'eventDateBegin', descending: true)
      .limit(50)
      .snapshots();
}

void addEventsBatch(List<Event> events) {
  events.forEach((Event event) {
    addEvent(event);
  });
}
