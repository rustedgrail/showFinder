fs = require 'fs'
https = require 'https'
parseString = require('xml2js').parseString

options =
  hostname: "https://gdata.youtube.com"
  port: 80
  method: 'GET'

fs.readFile 'shows.json', encoding: "utf8", (err, data) ->
  shows = JSON.parse data
  console.log shows
  for show in shows
    artist = show.headliner
    do (artist) ->
      queryString = "q=#{encodeURI(artist)}&v=2"
      options.path = "/feeds/api/videos?#{queryString}"
      https.get "#{options.hostname}#{options.path}", (res) ->
        xml = ''
        res.on 'data', (data) ->
          xml += data
        res.on 'end', () ->
          parseString xml, (err, result) ->
            console.log "result for #{artist}: #{result.feed.entry?[0].link[0]['$'].href}"
