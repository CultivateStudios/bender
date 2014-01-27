# Description:
#   prntscr
#
#   Set the environment variable HUBOT_HIPCHAT_API_KEY
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_HIPCHAT_API_KEY
#
# Commands:
#   mention a prntscr URL
#
# Author:
#   Joe Wegner

https = require 'https'
http = require 'http'
request = require 'request'



module.exports = (robot) ->
  rooms = {}

  # Enable a looser regex if environment variable is set
  regex = /http:\/\/prntscr\.com\/[0-9A-Za-z]+/i

  if process.env.HUBOT_HIPCHAT_API_KEY?
    hipchat_api_key = process.env.HUBOT_HIPCHAT_API_KEY
  else
    console.log "Missing HUBOT_HIPCHAT_API_KEY"
    return false

  robot.hear regex, (msg) ->

    url = msg.match[0];

    http.get url, (res) ->

      data = ""

      res.on 'data', (chunk) ->
        data += chunk

      res.on 'end', () ->
        match = data.match /<meta property="og:image" content="([^"]+)"\/>/ 

        if match.length == 2
          message = "<a href='#{url}><img src='#{match[1]}' width='400' /></a>"
          console.log message

          request
            url: "https://api.hipchat.com/v1/rooms/message?auth_token=#{hipchat_api_key}"
            method: "POST"
            form:
              from: "LightShot"
              room_id: rooms[msg.message.room]
              message_format: "html"
              color: "gray"
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
          new_rooms[room.name.toLowerCase().replace(" ", "_")] = room.room_id

        rooms = new_rooms

  setInterval updateRooms, 10 * 60 * 1000
  updateRooms()
        

            


          
