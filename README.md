VisaViz ToC
=========
  * [State (of current project)](#state)
  * [Swift (Problem)](#swift)
  * [Satin (Solution)](#satin)
  * [Scope (Project)](#scope)
  * [Story (Context)](#story)


## State

There are 2 Xcode projects:
1. VisaViz (working example in SwiftUI with 400 tweets)
2. MetalExperiments (“playground” for setting up Satin and getting acquainted)

I don’t really have anything done for the shader part.
I’m not expecting any code @rezaali but any you do share is amazing & super appreciated. (Satin is already making it easier for me to figure out Metal) 

I’m really looking for direction on:

**Q1:** How to transfer the data to the ForgeView? (Is attaching it as a variable to the Class the best way?)

**Q2:** Should the transformation (tweet → quad) of data be done before it’s given to the ForgeView or inside the Class? (Kind of like the bufferComputeSystem?)

Or am I thinking about this the wrong way?

## Swift

I’ve built the interface using SwiftUI. It works great as long as there <10K blocks. Then it slows down. A lot.

Visa has 140k tweets and he’s not slowing down.

## Satin

I’m hoping to be able to render at least 200k blocks. I think it should be possible using Satin + Metal. I feel confident writing Swift code but I just started learning Metal this week.

**Priorities:**
- Performance

**Nice to have:**
- Interactive blocks (show a popup on hover with tweet details)
	 - note: I can workaround using an overlay in SwiftUI if I can't figure it out

## Scope

1. Show ALL of a user’s tweets at once (no gimmicks, all of them)
2. Every tweet is a square block
	 1. Position is determined by a sorting (time, popularity, +) along a path (h/v rows, snake) in a 2d grid
		  1. Size of grid is determined by view size
		  2. Size of blocks is determined by how small they have to be to all fit in the view 
	 2. Color is determined by tweet properties:
		  1. Brightness by popularity
		  2. Hue is random except Tweet in a thread share the same hue

## Story

This project is a single visualization in a series that I am working on under an umbrella (project name [golOS](https://github.com/felixakiragreen/golos) - Game of Life Operating System)

golOS is a game about playing your own life as an RPG. It uses visualizations of life’s meaningful data to give a sense of progression and gamifies all the tedious “grindy” parts of life, like adulting & cleaning.

I discovered Visa through Twitter because he’s shared a lot of ideas about a thing like this. We both think it would be really cool to be able to visualize ALL your tweets in a single interface and explore them that way.

——//——

Other things:
[CHANGELOG](../CHANGELOG.md)
[DEVNOTES](../DEVNOTES.md)
