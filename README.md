# Week 3 - Assignment - *Flick Take 2*

**Movie viewer** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **16** hours spent in total

## User Stories

The following **required** functionality is completed:

***Pull Request 1 - Search***

- [x] User must be able to filter search results by adult content, release year, and primary release year, which are parameters to /search in the TMDB API. This should be done via a second view controller, called "filters".
- [ ] There should be a third tab, called search.
- [x] User should see a "no results found" placeholder in the table view if no results are found.

***Pull Request 2 - Favorite and Sharing***

- [x] User should be able to swipe right on the TableViewCells to expose favorite and share actions.
- [x] Movies that have been "favorited" should have a visual cue that they've been favorited, such as an icon or change in background color.
- [x] Make sure the "favorited" state persists as you scroll up and down the list of movies.
- [x] Selecting "share" should open a small ActionSheet.

***Pull Request 3 - Persisted Favoriting using Realm***

- [x] Closing the app and re-opening the app should "remember" the movies that you've favorited.
- [x] Local persistence: use Realm to remember which movies you've favorited.
- [x] Hint: you'll want to use the id field to correlate the movies together.

***Pull Request 4 - Persisted Favoriting using Firebase***

- [x] Sign up for an account using Firebase: https://www.firebase.com/docs/ios/quickstart.html.
- [x] Save your "favorited movies" to Firebase.

The following **bonus task** features are implemented:

- [x] Integrate MGSwipeTableCell to implement bi-directional swipe. Swipe left to favorite, and swipe right to share. Swipe left to favorite should trigger automatically upon completion of the swipe.
- [ ] Firebase Branch: Implement a "Feed View", where you can see all the favorite actions happening in a TableView.
- [ ] Sharing via Facebook, Twitter and More.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/rffWJK6.gif' title='Pull Request 1 - Search' width='240'/>    <img src='http://i.imgur.com/BBVbrq8.gif' title='Pull Request 2 - Favorite and Share' width='240'/>    <img src='http://i.imgur.com/a6kWgmG.gif' title='Pull Request 3 - Realm' width='240'/>

<img src='http://i.imgur.com/LIycvw3.gif' title='Pull Request 4 - Firebase'/>

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

- [x] Got a duplicate "favorited" state

## License

    Copyright [2016] [Tri Ngo Minh]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
