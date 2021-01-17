# VisaViz
An app to visualize all the tweets


@visakanv my plan is to give you a dev build ASAP to play around in, and I expect that you'll encounter "flows" that you want to have, so I'll make those
 (just different ways of slicing/viewing, since ~100K is almost too many to view at once.)


## Upcoming

- choose color based on Threads
- add sorting/filtering options
- showing threads with same color

- calculate gridItem size so that it fills the space, doesn't exceed it

- figure out a popularity value system for tweets (probably configurable, should consult Visa)

- set Timezone & DateFormat


### Metal Frontend

The whole grid view will need to be rewritten in order to support >10K tweets.
Going to use Metal for this.

### Open ideas
- filtering based on words
- TRIGRAPH from → @ollybot: If you can get the rendering fast enough, having a search bar and varying brightness of each box based on how many tri's it shares with the search term would be awesome (as an alternative to varying by popularity)
- add some neat stats



## Changelog


**12021·01·16**
- adding thread support

**12021·01·15**
- display all the tweets in a LazyGrid with random colors (sorted by date)
- show hovered tweet in sidebar
- click on a tweet to pin it
- set brightness based on popularity (rt*fav)

**12021·01·14**
- create basic Tweet model
- load tweets from Twitter archive

**12021·01·13**
- testing performance with 10k - 100k rectangles
