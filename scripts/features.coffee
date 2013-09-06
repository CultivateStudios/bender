# Description:
#   Bob Needs New Features
#
# Configuration:
# 
#
# Commands:
#	  hubot suggested features
#	  hubot new feature <feature>
#
# Author:
#   josephwegner

module.exports = (robot) ->

  if typeof robot.brain.data.newHubotFeatures is "undefined"
  	robot.brain.data.newHubotFeatures = []

  robot.respond /new feature (.*)/i, (msg) =>
  	if typeof msg.match[1] is "string"
  		possibleFeature = msg.match[1]

  		for feature in robot.brain.data.newHubotFeatures
  			if feature == possibleFeature
  				msg.send "Someone already suggested #{possibleFeature}.. Maybe @josephwegner will do it soon..."
  				return false

  		robot.brain.data.newHubotFeatures.push possibleFeature

  		msg.send "Sounds good to me!"

  	else
  		msg.send "That's a confusing way to say that"

  robot.respond /suggested features/, (msg) =>
  	if robot.brain.data.newHubotFeatures.length < 1
  		msg.send "No one has suggested any features.  I guess old bots can't learn new tricks."
  	else
  		msg.send "People have suggested #{robot.brain.data.newHubotFeatures.join(', ')}"


