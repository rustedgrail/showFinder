casper = require('casper').create()
 # verbose: true
 # logLevel: 'debug'o

headliners = []
venues = []
shows = []

getShowInformation = ->
  pageShows = []
  days = document.getElementsByClassName 'one-event'
  for day in days
    headliners = day.getElementsByClassName 'headliners'
    venue = day.getElementsByClassName 'venue location'
    for headliner in headliners
      pageShows.push 
        headliner: headliner.firstElementChild.innerHTML
        venue: venue[0].innerHTML
  pageShows

casper.start 'http://www.bowerypresents.com/see-all-shows/'

casper.then ->
  shows = @evaluate getShowInformation

casper.run ->
  @echo JSON.stringify shows
  @exit 'Finished'
