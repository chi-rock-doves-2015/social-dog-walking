Terriertory - Backbone fork of social-dog-walking

#Summary
This is an expansion on our initial Dev Bootcamp final project. Terriertory is a social dog walking webapp. Players register their dogs and map the paths they take on walks. They do so by manually pausing to "mark" territory, generating a series of points that will be plotted on a map and attached to their accounts and dogs.

Its interface is straightforward: A user creates an account and adds their dogs (though this is not necessary). The app has two main views: A dashboard that gives the user their current stats as well as those of nearby users, and a view for use while taking a walk. When they finish the walk, the user sees a completed walk view and then returns to their dashboard.

The Dashboard itself has 3 main sections: 
* A map, which can show either the user's own territory or an additional overlay of nearby users and their dogs
* A status bar used to deliver messages about the current state of the app
* If applicable, statistics relevant to the user such as their own dogs' information and that of nearby users.

This app uses a Postgresql database with Rails as its back end. It also integrates AWS for user profile pictures and PostGIS to facilitate location-based queries on nearby users' territory. As an extension to the initial project, we are refactoring the front end to use backbone.js as a client-side MV* framework.



#Group process
## Priorities
* Client-side MV*
* Cleaner mapping - server and client-side
* Views: Neighborhood rankings, Ajaxify user profiles
* Resolve what happens if you come from a desktop & other mobile media sizes
* Avatars
* Testing: optional, but don't break travis
* Unique Area


## Timeline
* Checkpoints
  - June 17: DBC Mixer
  - Will need to pay new heroku 50$
     - Or Digital Ocean?
  - June 5 Hackathon Weekend - many of us might be out.
  
### Checkpoints
- Backbone spike this weekend: if not in place by wed 6/3 we will withdraw, dry out existing map code.
- June 1-5: refine code to meet initial priorities
- Following weekend is hackathon
- June 8-12: refine code to meet secondary priorities
- June 13-14: Final Weekend! working product by sunday.



## Group Expectations
### Communication
- 8:15 Hangouts voice call standup M-F: 2 min each person + short discussion
- Josh to run the calls
- Trello, Slack preferred
- 6/3 we decided to allow more solo work because of varied work schedules, morning meeting and trello use stand
