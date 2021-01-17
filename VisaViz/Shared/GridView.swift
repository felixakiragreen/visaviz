//
//  GridView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/13/21.
//

import SwiftUI

// MARK: - PREVIEW
struct GridView_Previews: PreviewProvider {
	static var previews: some View {
//		GridView(tweets: .constant([]))
		GridView(
			archive: TweetArchive.previewData,
//			interaction: .constant(TweetInteraction())
//			tweets: .constant(Tweet.previewData),
			hovered: .constant(nil),
			pinned: .constant([])
		)
//		.environmentObject(TweetArchive())
//		.environmentObject(TweetInteraction())
//		.environmentObject(ColorRandom())
	}
}


struct GridView: View {
	// MARK: - PROPS
	
//	@EnvironmentObject var testArchive: TweetArchive
//	@EnvironmentObject var interaction: TweetInteraction
	
//	@EnvironmentObject var randomColor: ColorRandom
	
	@ObservedObject var archive: TweetArchive
//	@Binding var interaction: TweetInteraction
	
//	@Binding var tweets: [Tweet]
	@Binding var hovered: Tweet?
	@Binding var pinned: [Tweet]
	
	struct Config {
		var quantity: Int = 100
		var size: CGFloat = 10.0
		var space: CGFloat = 2.0
	}
	
	var config = Config()
	
//	let randomColor = ColorRandom(seed: "test")
	
	// MARK: - BODY
	var body: some View {
//		let randomColor = ColorRandom()
		
		LazyVGrid(columns: [GridItem(.adaptive(minimum: config.size, maximum: 100.0), spacing: config.space)], spacing: config.space, content: {
			ForEach(archive.allSorted.indices, id: \.self) { tweetIndex in
				let tweet = archive.allSorted[tweetIndex]
				let hue = tweet.hue ?? .grey
				
				let isOverTweet = hovered == tweet
				let isOverThread: Bool = {
					if let threadId = hovered?.links.threadId,
						let threadIndex = archive.threads.firstIndex(where: { $0.id == threadId }) {
//						print("hey")
						return archive.threads[threadIndex].tweets.contains(where: { $0.id == tweet.id })
					}
					return false
				}()
				let isPinned = pinned.contains(tweet)
				
				TweetBlock(tweet: tweet, hue: hue, isOverTweet: isOverTweet, isOverThread: isOverThread, isPinned: isPinned, height: config.size)
					.onHover { onHovering in
						if onHovering {
							hovered = tweet
		//							interaction.hovered = tweet
						} else {
//									hovered = nil
						}
					}
					.onTapGesture {
						if isPinned {
							guard let index = pinned.firstIndex(of: tweet) else {
								return
							}
							pinned.remove(at: index)
						} else {
							pinned.append(tweet)
						}
					}
			}
		})
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
		.padding(config.space)
		.onHover { onHovering in
			if !onHovering {
				hovered = nil
			}
		}
	}

//	var shape: some View {
//
//	}
}


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

		let color = ColorPreset(hue: hue, lum: lum, sys: false).getColor()
		
		Rectangle()
			.foregroundColor(color)
			.frame(height: height)
			.overlay(
//				Text("\(tweet.metrics.retweets) \(tweet.metrics.likes)")
				Text("\(popularity)")
					.foregroundColor(popularity >= 10 ? .black : .white)
			)
			.overlay(
				isOverTweet || isOverThread ?
					Rectangle()
					.strokeBorder(ColorPreset(hue: hue, lum: .medium, sys: false).getColor(), lineWidth: isOverTweet ? 6 : 3)
					: nil
			)
			.overlay(
				isStartOfThread ?
					Circle()
//					.inset(by: -2)
					.strokeBorder(ColorPreset(hue: hue, lum: .medium, sys: false).getColor(), lineWidth: 4)
					: nil
			)
			.overlay(
				!isStartOfThread && isInAThread ?
					Circle()
//					.inset(by: 4)
					.strokeBorder(ColorPreset(hue: hue, lum: .medium, sys: false).getColor(), lineWidth: 2)
					: nil
			)
	}
}
