//
//  TweetVisualsAtom.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/25/22.
//

import Atoms
import Foundation


struct TopColorsAtom: ValueAtom, KeepAlive, Hashable {
	func value(context: Context) -> [String:(Hue, Int)] {
		let archive = context.watch(TweetArchiveAtom())
		
		var _topColors: [String:(Hue, Int)] = [:]
		
		let topInteracted = archive.replyCount
			.sorted(by: {
				$0.value > $1.value
			})
			.prefix(6)
		
		for index in topInteracted.indices {
			let username = topInteracted[index].key
			let count = topInteracted[index].value
			let hue = Hue.allCases[index + 1]
			
			_topColors[username] = (hue, count)
		}
		
		return _topColors
	}
}


struct TweetVisualsAtom: ValueAtom, KeepAlive, Hashable {
	func value(context: Context) -> [TweetVisual] {
		let archive = context.watch(TweetArchiveAtom())
		let topColors = context.watch(TopColorsAtom())
		
		var _visuals: [TweetVisual] = []
		
		for tweet in archive.allTweets {
			if let username = tweet.replyUserName,
				topColors[username] != nil {
				_visuals.append(
					TweetVisual(
						id: tweet.id,
						hue: topColors[username]?.0 ?? .grey
					)
				)
			} else {
				_visuals.append(
					TweetVisual(
						id: tweet.id,
						hue: .grey
					)
				)
			}
		}
		
		return _visuals
	}
}

