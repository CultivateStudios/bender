# Description:
#   Send cultivated stuff to Social Storyboard
#
# Configuration:
#   HUBOT_SSB_API_URL
#
# Commands:
#   hubot cultivated <type> <link>
#
# Author:
#   josephwegner

https = require 'https'

module.exports = (robot) ->
  SSBAPI = process.env.HUBOT_SSB_API_URL

  robot.respond /.*cultivated.*/i, (msg) ->
    input = msg.match[0]

    switch
    	when input.indexOf("image") > -1
    		processImages input, msg
    	when input.indexOf("video") > -1
    		processVideos input, msg
    	when input.indexOf("vine") > -1
    		processVines input, msg

### Type Processing Functions ###

processImages = (input, msg) ->
	imageURL = getURL input

	if typeof imageURL != "string"
		msg.send "Did you forget the link, or am I just crazy?"
		return false

	#Let's test to see that it's really an image
	https.get imageURL, (res) ->
		if res.statusCode == 200
			#msg.send "Nice image, dude(tte)!  I'm #cultivating that right now!"
			msg.send "That's nice and all, but I'm not ready to cultivate stuff yet"
		else
			msg.send "Ehh, sorry.  Looks like you've got a screwed up image..."

processVideos = (input, msg) ->
	videoURL = getURL input

	if typeof videoURL != "string"
		msg.send "Did you forget the link, or am I just crazy?"
		return false

	#Let's test to see that it's really an image
	https.get videoURL, (res) ->
		if res.statusCode == 200
			#msg.send "That's a nicely #cultivated video!"
			msg.send "CANNOT COMPUTE!!!! (you should wait awhile before you cultivate stuff)"
		else
			msg.send "I don't really know how to tell you this...  I don't think that's a video"

processVines = (input, msg) ->
	vineURL = getURL input

	if typeof vineURL != "string"
		msg.send "Did you forget the link, or am I just crazy?"
		return false

	if vineURL.indexOf("vine.co") < 0
		msg.send "I see the link, but not the vine.  What do you think you're doing?"
		return false

	#Let's test to see that it's really an image
	https.get vineURL, (res) ->
		if res.statusCode == 200
			#msg.send "#cultivated #cultivated #cultivated #cultivated #cultivated"
			msg.send "/me is tangled up in vines"
			msg.send "Please don't do that yet..  All this cultivated stuff is too confusing right now..."
		else
			msg.send "Vine's having trouble with that link.  Ima go give 'em hell.  Try it again in a few minutes, maybe."

### Helper Functions ###
getURL = (base) ->
	base.match(/(https?:\/\/[^\s]+)/)[0]
