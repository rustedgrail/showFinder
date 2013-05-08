casper = require('casper').create()
 # verbose: true
 # logLevel: 'debug'o

headliners = []
venues = []
shows = []

getShowInformation = ->
  pageShows = []
  dates = document.getElementsByClassName 'data'
  for date in [0..14]
    days = dates[date].getElementsByClassName 'one-event'
    for day in days
      showDate = dates[date].getElementsByClassName('value-title')[0].title
      headliners = day.getElementsByClassName 'headliners'
      venue = day.getElementsByClassName 'venue location'
      for headliner in headliners
        pageShows.push 
          headliner: headliner.firstElementChild.innerHTML
          venue: venue[0].innerHTML
          date: showDate
  pageShows

casper.start 'http://www.bowerypresents.com/see-all-shows/'

casper.then ->
  shows = @evaluate getShowInformation

casper.run ->
  @echo JSON.stringify shows
  @exit 'Finished'
