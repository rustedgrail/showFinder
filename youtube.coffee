fs = require 'fs'
redis = require 'redis'
https = require 'https'
parseString = require('xml2js').parseString

options =
  hostname: "https://gdata.youtube.com"
  port: 80
  method: 'GET'

client = redis.createClient()
client.on 'error', (err) ->
  console.log "OHNOES!! #{err}"

saveLink = (show, res) ->
  xml = ''
  res.on 'data', (data) ->
    xml += data

  res.on 'end', () ->
    parseString xml, (err, result) ->
      link = result.feed.entry?[0].link[0]['$'].href
      if link
        key = "videos::#{show.headliner}::#{show.venue}::#{show.date}"
        client.set key, link, redis.print
        client.pexpire key, new Date(show.date).getTime()

getVideoForArtist = (show) ->
  queryString = "q=#{encodeURI(show.headliner)}&v=2"
  options.path = "/feeds/api/videos?#{queryString}"
  https.get "#{options.hostname}#{options.path}", saveLink.bind null, show

fs.readFile 'shows.json', encoding: "utf8", (err, data) ->
  shows = JSON.parse data
  for show in shows
    getVideoForArtist show
