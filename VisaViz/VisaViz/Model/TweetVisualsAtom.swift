//
//  TweetVisualsAtom.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/25/22.
//

import Atoms
import Foundation


struct MostInteractionsByColorAtom: ValueAtom, KeepAlive, Hashable {
	func value(context: Context) -> [String:(Hue, Int)] {
		let archive = context.watch(TweetArchiveAtom())
		
		/// username: (color, count)
		var _acc: [String:(Hue, Int)] = [:]
		
		let topInteracted = archive.replyCount
			.sorted(by: {
				$0.value > $1.value
			})
			.prefix(6)
		
		for index in topInteracted.indices {
			let username = topInteracted[index].key
			let count = topInteracted[index].value
			let hue = Hue.allCases[index + 1]
			
			_acc[username] = (hue, count)
		}
		
		return _acc
	}
}


struct TweetVisualsAtom: ValueAtom, KeepAlive, Hashable {
	func value(context: Context) -> [TweetVisual] {
		let archive = context.watch(TweetArchiveAtom())
		let topColors = context.watch(MostInteractionsByColorAtom())
		let gridState = context.state(GridAtom())

		var _acc: [TweetVisual] = []
		
		let max = archive.computeMax()
		for tweet in archive.allTweets {
			if let username = tweet.replyUserName,
				topColors[username] != nil {
				_acc.append(
					TweetVisual(
						id: tweet.id,
						hue: topColors[username]?.0 ?? .grey,
						lit: tweet.computeLit(max: max)
					)
				)
			} else {
				_acc.append(
					TweetVisual(
						id: tweet.id,
						hue: .grey,
						lit: tweet.computeLit(max: max)
					)
				)
			}
		}
		
		/// update the cell count when visuals update
		if gridState.wrappedValue.cellCount != _acc.count {
			gridState.wrappedValue.calcRows(count: _acc.count)
		}
		
		return _acc
	}
}

