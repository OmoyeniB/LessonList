# LessonList

An app that shows list of movies. The app makes a request to https://iphonephotographyschool.com/test-api/lessons to fetch movie list available, returns and displays the data from that query and displays the data in a list.

### App Overview:
The goal is to create a simple iOS application which makes a request to an url, parses the response, and displays the result in the UI. 

### Main Components:
The app consists of three main components:
- A LessonViewController: shows a list of available movies
- A DetailViewController consist of:
    - Movie details
    - Lesson Trailer Previewer


### Other components:
Other components in the app are:
- A detail component that is presented when a result item is tapped on is also available

# Requirements
- iOS Version ~> 13
- Xcode ~> 13 (10.0 compatible)
- Swift ~> 5.0

# Architecture
For this project I made use of an MVVM with Repository Pattern, using depedency injection to ensure separation of concerns and proper decoupling of code around the application. This separation of concern also makes the code easily testable.

# Performance Improvement
- Video caching, this saves the user's time and data
- Activity indicators to notify users of tasks
- LPLinkView is used to preview video before it is played

# Screenshots
Some screenshots of the app are shown below:

###  Lesson List
<img width="236" alt="Screenshot 2023-01-11 at 13 00 47" src="https://user-images.githubusercontent.com/92518636/212325059-cc7e253a-6e52-4ee8-bf3b-527d3cc6e38d.png">

### Lesson Details Page 
![Simulator Screen Shot - iPhone X - 2023-01-13 at 13 56 32](https://user-images.githubusercontent.com/92518636/212325356-f53175ba-2fe4-4136-bb79-df6342a5489a.png)




