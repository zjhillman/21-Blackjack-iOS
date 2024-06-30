# 21 - The open source game of Blackjack for iOS!

This project aims to build the fundamentals of Swift and SwiftUI to create a fun and minimal game of Blackjack!

## Building the Cards
![Back of Playing Card](https://github.com/zjhillman/21-Blackjack-iOS/blob/e8dab1d8179cee06ba88a2f5abeb14fafda995e2/Assets.xcassets/Cards/back.imageset/back.svg)
![Playing Card: Jack](https://github.com/zjhillman/21-Blackjack-iOS/blob/e8dab1d8179cee06ba88a2f5abeb14fafda995e2/Assets.xcassets/Cards/card11.imageset/card11.svg)

The first view to be constructed was the PlayingCard View, which consists of two svg images stacked on top of each other. 
SVG files were used to create a scalable object that would look good at multiple resolutions.
The images were given an animation to flip over so that either the back of the card would face up or the suit of the card would face up, allowing for cards to be shown upside down and then revealed later.
This data model was named CardData to be able to hold relavent data for every playing card on the screen, and easily allows multiple cards to be added and controlled individually from each other.

## Building the Hand Data Structure

The next thing that had to be created was something to represent the physically "hand" of cards in play.
In real life, the dealer would have a collection of cards in their hand while the player would also have their own set of cards in their hand.
This let to the next data structure, named HandData, which is mostly a glorified list of CardData items.
In other words, HandData is a list of CardData structures that can edit the information of the cards as well as keep the playing hand data seperate from another hand (dealer vs player).

## The Title Screen

The Title Screen was a great way to test that the data structures work and that the data can manipulated from the view function call, through the HandData class, and into the individual CardData classes as needed.
The Title screen starts by showing two cards face down and immediately creates a timer.
Every 5 seconds, a random card will be chosen to be flipped over. In this case, only two exists so either the left or right card will flip over.
The title screens does not need much data, as it's job is to appear somewhat "flashy." 
So two big cards were shown and a simple start button to start the game of blackjack itself.
Initially I had problems getting a view to alter data in child views, this is where I learned that I wasn't suppoed to use @State and @Binding wrappers.
Instead, I had to ensure that the classes were labeled as ObservableObjects with @Published wrappers on important variables.
Then The Views had to use an @ObservedObject wrapper to watch for data changes in the model to reflect in the Views.

## Creating the Play Space

Now that the data models are in place and can be manipulated properly, a space had to be created to show all of the data structures.
A PlayingHand view was added for the dealer as well as the player, along with buttons for actions that can be taken in the game (Hit, Stand).
Next, a Blackjack data model was created to keep track of the rules of the game and manage specific data related to the game of Blackjack.
