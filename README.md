# README – Welcome to Around Town! 
![](ReadmeAssets/Walkthrough.gif)

## Summary 

    AroundTown is an app that allows users to see cool places near them based on what the type of venue they are looking for. It leverages 
    the FourSquare API to source places based on the user's coordinates. Users can scroll a table view of populated results, and click on 
    a card to take them to a detailed view of the location. The detailed view contains information like the address, website, and telephone number. 
    It also includes a map view, so the user can see what part of the city it is located in. Additionally the user can navigate to the 
    venue's webpage.

### Architectural Overview

![](ReadmeAssets/DataFlow.png)
A Visual Overview of the relationships within the app 
    
    I designed this application using the MVC architectural pattern. With this being the case, I wanted to separate the data fetching classes 
    into Models, so the VenueModel is the only part of the application that interacts with the FourSquare API. Additionally, I created an additional 
    LocationModel to handle the parsing and communication of the user's location. These two models send information based on the ViewController's 
    request, allowing the ViewController to contain access the the entire venues data object. 
    
    To display each venue, I made the ViewController the delegate of the venueTable object. I implemented a custom venueCell class to achieve 
    my desired look for the tableCell, and registered it to the venueTable object. Through the venueTable's protocol methods in the View 
    Controller, I was able to pass the single venue object to the detailViewController when the user clicked the venue card by assigning it 
    to the venue property in detailViewController. I then populated the view for detailViewController using the venue object. The venue 
    object contained the street address for the location, which I sent to my MapView class to display and set up the mapView. 
    
    Lastly, I implemented a clickHandler for the website section in the detailViewController that adds the WebViewController to the navigation 
    stack. The detailViewController assigns the website url to a property contained in WebViewController. WebViewController then uses 
    this information to make a url request to display the venue's webpage. 
    
## Requirements

    ### Use of at least two screens, all screens should be accessible from another screen
    
    ### Two Screens should have direct interactions 
    
    ### Usage of MVC MVVM architectural pattern
    
    ### Integration with oneAPI
    
    ### Use of at least 5 different UI Components 
        
        1. Labels
        2. Buttons
        3. UIStackViews
        4. TableView
        5. MapView
        6. WKWebView


## Process 

## Libraries / API's Used

    ### Four Square API 
        
    ### Core Location
        
    ### MapKit 
        
    ### WebKit

## How to Setup 

1. Fork this repository. 
    
2. Open up terminal on your machine. 
    
3. In terminal, git clone this repository: 
    ```git clone https://github.com/josiei/AroundTown.git```
        
4. In terminal, cd into the repository and open it:
        ``` 
        cd <repo-name> 
        ```
        ```
        open <repo-name>.xcodeproj
        ```
5. Once the project is open, press the play button in the top left corner. 
    
    Note: This project does not use a package manager like Cocoapods, but you may 
    need to add the WebKit framework to `Frameworks, Libraries, and Embedded Content`
    in the General settings depending on your version of Xcode. 

## Decisions and Tradeoffs

    ### MVC Pattern
        
    ### Using delegate pattern for venueTable in ViewController 
        
    ### Passing data through using a property for DetailViewController and WebViewController
        
    ### Encapsulating MapView and Venue Cell
        
    ### Using Image Cache 
        
    ### Using Notification center for detecting change in user's location
        
    ### Using a combination of AutoLayout and Stacks Views to layout UI programmatically
    
    ### Use of animations 

## Future Optimizations 

    ### Adding directions from user's location to venue's location
    
    ### Adding the ability to click the phone number and have a pop up that asks if you'd like to call the number 
    
    ### Investigating other API's like Foursquare places to see if they contain more data to integrate 
    
## 

