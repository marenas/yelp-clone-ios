# Project 2 - Pley

Pley is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: 12 hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] Search results page
   - [X] Table rows should be dynamic height according to the content height.
   - [X] Custom cells should have the proper Auto Layout constraints.
   - [X] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [X] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [X] The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
   - [X] The filters table should be organized into sections as in the mock.
   - [X] You can use the default UISwitch for on/off states.
   - [X] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   - [X] Display some of the available Yelp categories (choose any 3-4 that you want).

The following **optional** features are implemented:

- [ ] Search results page
   - [ ] Infinite scroll for restaurant results.
   - [ ] Implement map view of restaurant results.
- [] Filter page
   - [ ] Implement a custom switch instead of the default UISwitch.
   - [X] Distance filter should expand as in the real Yelp app
   - [X] Categories should show a subset of the full list with a "See All" row to expand. Category list is [here](http://www.yelp.com/developers/documentation/category_list).
- [ ] Implement the restaurant detail page.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![Video Walkthrough](pley-walkthrough.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

The main challenge was to maintain a working set of filter parameters between the main view controller and the filter view controller. It wasn't hard per se, but the first implementation was really messy as I was adding each filter one by one. I had to create a filter class so the set of filter parameters was easier to send back and forth between the 2 views.

## License

    Copyright [2015] [Matias Arenas]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.