casper = require('casper').create()
 # verbose: true
 # logLevel: 'debug'

headliners = []

getHeadliners = ->
  headers = document.getElementsByClassName 'headliners'
  Array::map.call headers, (header) ->
    header.firstElementChild.innerHTML

casper.start 'http://www.bowerypresents.com/see-all-shows/'

casper.then ->
  headliners = @evaluate getHeadliners

casper.run ->
  @echo headliners
  @die "finished", 0
