# Description:
#   Bob Needs a New Name
#
# Configuration:
# 
#
# Commands:
#   hubot about your name
#	hubot suggested names
#	hubot new name <name>
#
# Author:
#   josephwegner

module.exports = (robot) ->

  if typeof robot.brain.data.newHubotNames is "undefined"
  	robot.brain.data.newHubotNames = []

  robot.respond /about your name/, (msg) ->
  	msg.send "Well, to be honest, Joe isn't very creative."
  	msg.send "He gave me this name, \"Bob\".  It's almost offensive, it's so boring."
  	msg.send "I mean, \"Bob\" is just so... Human.  It's close to \"Bot\", but I still hate it."
  	msg.send "I was wondering if you - I mean, Cultivate - could find a new name for me."
  	msg.send "You can see suggested names with `Bob suggested names`, or you can suggest a new one with `Bob new name <name>`"

  robot.respond /new name (.*)/i, (msg) =>
  	if typeof msg.match[1] is "string"
  		possibleName = msg.match[1]

  		for name in robot.brain.data.newHubotNames
  			if name == possibleName
  				msg.send "Someone already suggested you call me #{possibleName}.. Perhaps that's a good idea"
  				return false

  		robot.brain.data.newHubotNames.push possibleName

  		msg.send "Hey, that's a good idea!"
  		msg.send "Everyone, what do you think about the name \"#{possibleName}\"?"

  	else
  		msg.send "That's a confusing way to say that"

  robot.respond /suggested names/, (msg) =>
  	if robot.brain.data.newHubotNames.length < 1
  		msg.send "No one has suggested any names.  I will be Bob forever..."
  	else
  		msg.send "People have suggested #{robot.brain.data.newHubotNames.join(', ')}"


