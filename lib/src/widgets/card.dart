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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/event.dart';
import 'stars.dart';

class EventCard extends StatelessWidget {
  EventCard({
    this.event,
    @required RestaurantPressedCallback onRestaurantPressed,
  }) : _onPressed = onRestaurantPressed;

  final Event event;

  final RestaurantPressedCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: () => _onPressed(event.id),
      splashColor: Colors.blue.withAlpha(30),
      child: Container(
        height: 250,
        child: Column(
          children: <Widget>[
            // TODO: Make this a Hero widget so we can transition to it?
            Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(event.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: null),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          event.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Text(
                        '\$' * 2,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, (kIsWeb ? 0 : 2), 0, 4),
                    alignment: Alignment.bottomLeft,
                    child: StarRating(
                      rating: 2,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      event.category + ' - ' + event.place + ' - ' + event.price.toString() + ' - ' + event.eventDateBegin.toString(),
                      style: Theme.of(context).textTheme.caption,
                      // '${event.category} ● ${event.city}',
                      // style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
