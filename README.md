# VisaViz
An app to visualize all the tweets


## Upcoming

- change Brightness based metrics
- choose color based on Threads
- add sorting options

- calculate gridItem size so that it fills the space, doesn't exceed it

### Metal Frontend

The whole grid view will need to be rewritten in order to support >10K tweets.
Going to use Metal for this.

## Changelog

**12021·01·15**
- display all the tweets in a LazyGrid with random colors (sorted by date)
- show hovered tweet in sidebar
- click on a tweet to pin it

**12021·01·14**
- create basic Tweet model
- load tweets from Twitter archive

**12021·01·13**
- testing performance with 10k - 100k rectangles
