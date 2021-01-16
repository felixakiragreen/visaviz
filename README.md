# VisaViz
An app to visualize all the tweets


## Upcoming

- choose color based on Threads
- add sorting/filtering options
- showing threads with same color

- calculate gridItem size so that it fills the space, doesn't exceed it

- figure out a popularity value system for tweets (probably configurable, should consult Visa)

### Metal Frontend

The whole grid view will need to be rewritten in order to support >10K tweets.
Going to use Metal for this.

### Open ideas
- filtering based on words


@visakanv my plan is to give I'm going once I can give you a dev build to play around in, I expect that you'll encounter "flows" that you want, so I'll make those
 (just different ways of slicing/viewing, since ~100K is so  many fucking tweets. holy shit I have a new appreciation of how big 100K is.)

## Changelog

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
