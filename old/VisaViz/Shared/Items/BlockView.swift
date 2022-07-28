//
//  BlockView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/17/21.
//

import SwiftUI

struct BlockView: View {
	let block: BlockRect
	
//	let isOverTweet: Bool
//	let isOverThread: Bool
//	let isPinned: Bool

	
	var body: some View {
		let tweet = block.t
		let hue = tweet.hue ?? .grey
//		let isStartOfThread = tweet.links.threadId == tweet.id
//		let isInAThread = tweet.links.threadId != nil

		let popularity = (tweet.metrics.retweets + 1) * (tweet.metrics.likes + 1)
		let lum: ColorLuminance = {
			switch popularity {
			case 200..<Int.max:
				return .nearWhite
			case 20..<200:
				return .extraLight
			case 10..<20:
				return .normal
			case 5..<10:
				return .semiDark
			case 1..<5:
				return .extraDark
			default:
				return .extraDark
			}
		}()

		let color = ColorPreset(hue: hue, lum: lum, sys: false)
//		isOverThread ? color.getQuarternaryColor() : 
		
		Rectangle()
			.foregroundColor(color.getColor())
			.frame(width: block.w, height: block.h)
			.offset(x: block.x, y: block.y)
	}
}


//struct BlockView_Previews: PreviewProvider {
//
//	static let block = BlockRect(id: 0, x: 0, y: 0, w: 10, h: 10, t: Tweet(fullText: "2345"))
//
//	static var previews: some View {
////		BlockView(block: block)
//	}
//}

struct TweetBlock: View {
	let tweet: Tweet
	let hue: ColorHue

	let isOverTweet: Bool
	let isOverThread: Bool
	let isPinned: Bool

	let height: CGFloat

	var body: some View {
		let isStartOfThread = tweet.links.threadId == tweet.id
		let isInAThread = tweet.links.threadId != nil

		let popularity = (tweet.metrics.retweets + 1) * (tweet.metrics.likes + 1)
		let lum: ColorLuminance = {
			switch popularity {
			case 200..<Int.max:
				return .nearWhite
			case 20..<200:
				return .extraLight
			case 10..<20:
				return .normal
			case 5..<10:
				return .semiDark
			case 1..<5:
				return .extraDark
			default:
				return .extraDark
			}
		}()

		let color = ColorPreset(hue: hue, lum: lum, sys: false)

		Rectangle()
			.foregroundColor(isOverThread ? color.getQuarternaryColor() : color.getColor())
			.frame(height: height)
//			.overlay(
			////				Text("\(tweet.metrics.retweets) \(tweet.metrics.likes)")
//				Text("\(popularity)")
//					.foregroundColor(popularity >= 10 ? .black : .white)
//			)
			.overlay(
				isPinned ?
					Rectangle()
					.inset(by: -3)
					.strokeBorder(color.getQuarternaryColor(), lineWidth: 3)
					: nil
			)
			.overlay(
				TweetBlockOverlay(isThreaded: isInAThread, isOverThread: isOverThread, isStartOfThread: isStartOfThread, color: color)
			)
			.overlay(
				isOverTweet ?
					Rectangle()
					.strokeBorder(color.getSecondaryColor(), lineWidth: 3)
					: nil
			)
			.animation(.default)
	}
}

struct TweetBlockOverlay: View {
	let isThreaded: Bool
	let isOverThread: Bool
	let isStartOfThread: Bool
	let color: ColorPreset

	var body: some View {
		if isThreaded {
			if isOverThread {
				Circle().foregroundColor(color.getColor())
			} else {
				Circle()
					.strokeBorder(color.getTertiaryColor(), lineWidth: isStartOfThread ? 6 : 3)
			}
		}
	}
}
