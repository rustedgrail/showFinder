fs = require 'fs'

casper = require('casper').create()
 # verbose: true
 # logLevel: 'debug'o

spotifyBase =
  host: 'http://ws.spotify.com/search/1/album'
  port: 80
  path: 'album?artist.json'

headliners = []

getHeadliners = ->
  headers = document.getElementsByClassName 'headliners'
  for header in headers
    header.firstElementChild.innerHTML

casper.start 'http://www.bowerypresents.com/see-all-shows/'

casper.then ->
  headliners = @evaluate getHeadliners

casper.run ->
  @echo headliners
  @die '', 0
