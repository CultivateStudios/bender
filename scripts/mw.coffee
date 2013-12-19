# Description:
#   Compilment mark
#
# Dependencies:
#   None
#
# Configuration:
#
# Commands:
#   mention Mark Weirda
#
# Author:
#   joe wegner

messages = [
  "{mw}, you deserve a pat on the back",
  "You're doing a great job today, {mw}",
  "Let's hear it for {mw}!",
  "{mw}, I love your shirt!",
  "Sweet pants, {mw}",
  "What in the world would we do without {mw}?",
  "ALL HAIL {mw}",
  "You know how sometimes you just walk in the office door, see {mw} taking too long making a coffee, and you just think, \"Man, {mw} is a real class act}\".  I'm feelin' that right now.",
  "For {mw} 's a jolly good fellow, for {mw} 's a jolly good fellow...  For {mw} 's a jolly good fellow, and nobody can deny!",
  "{mw}, great job on that coffee this morning.  You da man",
  "No matter what Casey says, you *are* good at something, {mw}",
  "Look at you, {mw}...  Rockin' that standing desk all day.  You're an inspiration to us all.",
  "(highfive) {mw}!",
  "Look at {mw} 's awesome mug (mark)"
]

module.exports = (robot) ->

  mw = robot.brain.userForName "Mark Wierda"

  if mw
    regex = new RegExp "@#{mw.mention_name}"

    robot.hear regex, (msg) ->
      msg.send msg.random(messages).replace "{mw}", "@#{mw.mention_name}"
  else
    console.log "could not find Mark..  sorry dude"

