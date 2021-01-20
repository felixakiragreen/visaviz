#  Notes

@visakanv my plan is to give you a dev build ASAP to play around in, and I expect that you'll encounter "flows" that you want to have, so I'll make those
 (just different ways of slicing/viewing, since ~100K is almost too many to view at once.)


## Upcoming

- generate a grid & use it place all blocks
	- calculate gridItem size so that it fills the space, doesn't exceed it
- move the "popup" to next to the hovered tweet (show/hide after brief delay)
- show (2/5) on threads
- add sorting/filtering options

- set Timezone & DateFormat
- make entities (URLs, users, &c) linkable

- open any "tweet.js" file

### TO FIX
- grid colors don't adapt to system yet

### Metal Frontend

The whole grid view will need to be rewritten in order to support >10K tweets.
Going to use Metal for this.


### Open ideas
- filtering based on words
- TRIGRAPH from → @ollybot: If you can get the rendering fast enough, having a search bar and varying brightness of each box based on how many tri's it shares with the search term would be awesome (as an alternative to varying by popularity)
- add some neat stats (# tweets, # threads, tweet/thread ratio, most common entities/trigraphs/emojis?)
- variety of color schemes
	- threads colors, nonthreads grey
	- retweets, quotes, replies
	- create your own (assign colors to threads, entities, keywords, &c)
- something with emojis
- configurable popularity value system for tweets

### Distant

- show media assets in preview
- show newest tweets using twitter integration
