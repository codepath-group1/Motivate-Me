# MotivateMe

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
[MotivateMe is an iOS app, which sends quotes daily, and motivate users.
Users can easily save their favorite quotes, and forward them on other 
social media.]

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:**
    Business, Utility, Reference
- **Mobile:**
    All iPhone
- **Story:**
    To stop people being procasnating, and motivate them daily by sending quotes to them. 
- **Market:**
    Our target users will be who want to do self-development. 
- **Habit:**
    The app will send a mount of quotes to users daily.
- **Scope:**
    For ambious people, and all age range.
## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories (High Priority)**

* A user can receive notification with random quote
* A user favorite a quote
* A user can browse the list of favorite quotes
* A user can browse the history of notification quotes
* A user can adjust the notification schedule
* A user can browse quotes by category

**Optional Nice-to-have Stories**

**(Medium Priority)**
* A user can login
* A user can save their data on our server
* A user can see the number of favorites on each quote
* Minimalistic design
* A user can leave a note on a quote (Personal Use)
* A user can see the most favorited quotes
* A user can save their personal quote
* A user can receive notification with tailored quote

**(Low Priority)**
* A user can share their quote list on the app
* A user can browse the books by the author of quotes
* A user can choose random quote or similar category quote
* A user can search quote with text
* A user can listen to Audio of quotes
* A user can make NotToDo list
* A user can change theme color
* A user can have more quotes


### 2. Screen Archetypes

* [list first screen here]
   * [list associated required story here]
   * ...
* [list second screen here]
   * [list associated required story here]
   * ...

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* [Home page]
* [Search page]
* [Favorite page]
* [Setting page]

**Flow Navigation** (Screen to Screen)

* [Loading page]
   * [Switch to login-in page]
* [Login-in page]
   * [After login in, swtich to home page]
* [Home page]
   * [Each quote, can be 'like','forward to other social media', or 'make comment']
   * [There are two modes to view daily quotes]
* [Search page]
   * [Can filter different categories of quotes]
* [Favorite page]
   * [Can view own favorite quotes, and make comment for each one, or make a collection]
* [Setting page]
   * [There are a couple of customerlize features]
## Wireframes
*[Sketch file vidoe]
<img src='http://g.recordit.co/UkZ3FuWS2T.gif' width=600>

*[Vidoe Interactive Prototype]
<img src='http://g.recordit.co/xhOlCIjQeG.gif' width=600>

### [BONUS] Digital Wireframes & Mockups
http://g.recordit.co/xhOlCIjQeG.gif
### [BONUS] Interactive Prototype
http://g.recordit.co/xhOlCIjQeG.gif
## Schema 
### Models

| Object | Description |
| ------------- | -------- |
| Quote | Quote object |
| Source | Quote Source could be author, movie, comic, etc |
| User | User of the app |
| Note | note to a quote |


**Quote**

| Property      | Type     | Description |
| ------------- | -------- | ------------|
| objectId      | String | id |
| SourceId | String | objectId of source |
| favoriteCount | Number | number of favorites for the quote |
| text | String | Content of this quote |

**Source**

| Property      | Type     | Description |
| ------------- | -------- | ------------|
| objectId      | String | id |
| quotes | [String] | list of objectId for quotes by this source |

**User**

| Property      | Type     | Description |
| ------------- | -------- | ------------|
| objectId      | String | id |
| favoritedQuotes | [String] | list of objectId for quotes favorited by this user |
| notificationHistory | [String] | list of objectId for quotes that was sent to the user on notification |
| userId | String | the user's email |
| notes | [String] | objectId of notes owned by the user |

**Note**

| Property      | Type     | Description |
| ------------- | -------- | ------------|
| objectId      | String | id |
| quoteId | String | objectId of the quote this note left with |
| text | String | content of this note |
| createdAt | Datetime | time the note was made |
| modifiedAt | Datetime | time the note was modified last time |


### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
