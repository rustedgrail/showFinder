fs = require 'fs'
http = require 'http'

stream = fs.readFile 'tmo', {encoding: 'utf-8'}, (err, data) ->
  console.log data

  for headliner in data
    http.get "http://ws.spotify.com/search/1/artist.json?q=#{headliner}", (res) ->
      res.on 'data', (chunk) ->
        res.setEncoding 'utf-8'
        console.log chunk
