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

import 'package:cloud_firestore/cloud_firestore.dart';

import './values.dart';

typedef RestaurantPressedCallback = void Function(String eventId);

typedef CloseRestaurantPressedCallback = void Function();

class Event {
  final String id;
  final String name;
  final String description;
  final Timestamp eventDateBegin;
  final Timestamp eventDateEnd;
  final String image;
  final String location;
  final String organizer;
  final num price;
  final String category;
  final String place;
  final DocumentReference reference;

  Event._({this.name, this.description, this.eventDateBegin, this.eventDateEnd, this.image, this.location, this.organizer, this.price, this.place, this.category})
      : id = null,
        reference = null;

  Event.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        name = snapshot.data()['name'],
        description = snapshot.data()['description'],
        eventDateBegin = snapshot.data()['eventDateBegin'],
        eventDateEnd = snapshot.data()['eventDateEnd'],
        image = snapshot.data()['image'],
        location = snapshot.data()['location'],
        organizer = snapshot.data()['organizer'],
        price = snapshot.data()['price'],
        place = snapshot.data()['place'],
        category = snapshot.data()['category'],
        reference = snapshot.reference;


  factory Event.random() {
    return Event._(
      name: getRandomName(),
      description: getRandomName(),
      eventDateBegin: getRandomTimpestamp(),
      eventDateEnd: getRandomTimpestamp(),
      image: getRandomPhoto(),
      location: "48.12222334611618, -1.615604648578558",
      organizer: getRandomName(),
      price: Random().nextInt(3) + 3,
      place: getRandomPlace(),
      category: getRandomCategory(),
    );
  }
}
