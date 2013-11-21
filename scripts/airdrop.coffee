# Description:
#   Aidrop
#
#   Set the environment variable HUBOT_EXTRA_AIRDROP (to anything)
#   for additional airdrop images
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_EXTRA_AIRDROP
#
# Commands:
#   airdrop - displays an airdrop image
#
# Author:
#   maddox

airdrop = [
  "http://www.southpolestation.com/trivia/00s/airdrop0a0.jpg",
  "http://www.design-simulation.com/Documents/IP/images/simulationimages/projectiles/airdrop.gif",
  "http://24.media.tumblr.com/1db85a81e4d299063c7368a661ee447f/tumblr_mr9mchP74x1s2yegdo1_400.gif",
  "http://www.militaryimages.net/photopost/data/716/Vietnam_War_Air_Drop_Of_Supplies_In_Operation_Junction_City.jpg",
  "http://cdn.memegenerator.net/instances/400x/31625529.jpg",
  "http://cdn.memegenerator.net/instances/250x250/42955820.jpg"
]

module.exports = (robot) ->

  # Enable a looser regex if environment variable is set
  regex = /airdrop/i


  robot.hear regex, (msg) ->
    msg.send msg.random airdrop