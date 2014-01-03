# Description:
#   Planscope
#
#   Set the environment variable HUBOT_HIPCHAT_API_KEY
#   Set the environment variable HUBOT_PLANSCOPE_API_KEY
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_HIPCHAT_API_KEY
#   HUBOT_PLANSCOPE_API_KEY
#
# Commands:
#   mention a planscope task URL
#
# Author:
#   Joe Wegner

https = require 'https'
request = require 'request'



module.exports = (robot) ->
  rooms = {}

  # Enable a looser regex if environment variable is set
  regex = /https:\/\/planscope\.io\/projects\/([^\/]+)\/tasks\/([0-9]+)/i

  if process.env.HUBOT_HIPCHAT_API_KEY?
    hipchat_api_key = process.env.HUBOT_HIPCHAT_API_KEY
  else
    console.log "Missing HUBOT_HIPCHAT_API_KEY"
    return false

  if process.env.HUBOT_PLANSCOPE_API_KEY?
    planscope_api_key = process.env.HUBOT_PLANSCOPE_API_KEY
  else
    console.log "Missing HUBOT_PLANSCOPE_API_KEY"
    return false  

  robot.hear regex, (msg) ->
    if msg.match.length >= 3
      project = msg.match[1]
      task_id = parseInt msg.match[2]

      url = "https://planscope.io/api/projects/#{project}/tasks.json?api_key=#{planscope_api_key}"

      https.get url, (res) ->

        data = ""

        res.on 'data', (chunk) ->
          data += chunk

        res.on 'end', () ->
          try
            tasks = JSON.parse data
          catch e
            console.log "Invalid JSON from planscope"
            return false

          matched_task = false
          for task in tasks
            if task.task.id_in_project == task_id
              matched_task = task.task
              break;

          if matched_task
            message = "<img height='16' src='https://planscope.io/assets/dot-logo.png' />&nbsp;&nbsp;<b>#{matched_task.name}</b>"

            request
              url: "https://api.hipchat.com/v1/rooms/message?auth_token=#{hipchat_api_key}"
              method: "POST"
              form:
                from: "Planscope"
                room_id: rooms[msg.message.room]
                message_format: "html"
                color: "purple"
                message: message
            , (error, response, body) ->
              console.log error, body


  updateRooms = () ->
    https.get "https://api.hipchat.com/v1/rooms/list?auth_token=#{hipchat_api_key}", (res) ->
      data = ""

      res.on 'data', (chunk) ->
        data += chunk

      res.on 'end', () ->
        try
          retrieved_rooms = JSON.parse data
        catch e
          console.log "invalid JSON from hipchat"
          return false

        new_rooms = {}

        for room in retrieved_rooms.rooms
          new_rooms[room.name] = room.room_id

        rooms = new_rooms

  setInterval updateRooms, 10 * 60 * 1000
  updateRooms()
        

            


          
