# Find Your House

Find Your House is a Command Line App that allows a Buyer to Purchase a house. Finding a house can be confusing
there are so many different options and to many things to look at. That is where an Agent comes in handy
our goal was to make the experience of finding an Agent easy. Once you have an agent they can do the hard part
of sifting through all the houses you wouldn't want. This way you can find the house of your dreams without 
having to deal with the inconvenient parts.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

To run this app you will need Ruby version 2.7.1. Can be found at https://www.ruby-lang.org/en/downloads/

### Installing

Once you have pulled the repository from Git Hub, please follow these steps:

1) In you terminal go to the repository
2) In your terminal type 'bundle install' to download all nessecary gems
3) In your terminal type 'rake db:migrate' to set up your database
4) In your terminal type 'rake db:seed' to create data in your database
5) You can now run the run.rb file to test code

### Interactions

- Log In: This allows the user to sign into an already created buyer
- Create User: This allows the user to create a new buyer on the system
- Help: Lists all interactions the user can do on the system
- List All Houses: List all Houses that are in the database
- Agent: To choose or Switch your Agent. You need an agent to buy a house
- Agents Houses: List all the houses your agents has in their portfolio
- Change Budget: Allows the user to change what there budget is
- Buy House: Allows the user to buy the house they want and take it off the market
- Visit House: Allows the user to set up a tour of the house. Needed to buy a house
- Visited Houses: All Houses the buyer has visited
- Delete Buyer: Delete account
- Log Out: Allows you to switch accounts
- Exit: Leave the app

### Authors

- Aidan Muller-Cohn
- Qiuyan (Nicole) Peng 

### Questions

- Can you buy a house above your budget?
  Yes, however the house must still have the same agent as you and you must have visited the house.
- What happened to my house visits?
  If you switch agents it will delete all previous house visits
- Why dont I have a house after switching agents?
  If you left the app before visiting a house then it wont link the agent to you.

### License

This code is free to use under the terms of the Flatiron License.