//
//  TweetHoverView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/26/22.
//

import Atoms
import SwiftUI

struct TweetHoverView: View {
	
	@WatchStateObject(TweetArchiveAtom())
	var archive
	
	@Watch(TweetVisualsAtom())
	var visuals
	
	@WatchState(GridAtom())
	var grid
	
	var hover: CGPoint
	var scroll: CGFloat
	
	var container: CGSize = CGSize(width: 300, height: 200)
	
	var body: some View {
		if let tweetIndex = getTweetIndex() {
			let tweet = archive.allTweets[tweetIndex]
			let vis = visuals[tweetIndex]
			TweetView(
				tweet: tweet,
				lit: vis.lit,
				size: container
			)
				.position(getPosition())
		}
	}
	
	func getPosition() -> CGPoint {
		let isLeft = hover.x < grid.containerWidth / 2
		let isTop = hover.y < grid.containerHeight / 2
		
		let forLeft = hover.x + container.width / 2
		let forRight = hover.x - container.width / 2
		let forTop = hover.y + container.height / 2
		let forBottom = hover.y - container.height / 2

		if isTop {
			if isLeft {
				return CGPoint(x: forLeft, y: forTop)
			} else {
				return CGPoint(x: forRight, y: forTop)
			}
		} else {
			if isLeft {
				return CGPoint(x: forLeft, y: forBottom)
			} else {
				return CGPoint(x: forRight, y: forBottom)
			}
		}
	}
	
	func getCellSlot() -> (Int, Int) {
		let columnIndex = Int(floor(
			hover.x / grid.cellWidth
		))
		let rowIndex = Int(floor(
			(hover.y - scroll) / grid.cellWidth
		))
		
		return (columnIndex, rowIndex)
	}
	
	func getTweetIndex() -> Int? {
		let slot = getCellSlot()
		let columnIndex = slot.0
		let rowIndex = slot.1
		
		let index = columnIndex + (rowIndex * grid.columns)
		
		if index < archive.allTweets.count {
			return index
		}
	
		return nil
	}
}

struct TweetHoverView_Previews: PreviewProvider {
	static var previews: some View {
		TweetHoverView(
			hover: CGPoint(x: 200, y: 200),
			scroll: 0
		)
			.embedAtomRoot()
			.preferredColorScheme(.dark)
	}
}
