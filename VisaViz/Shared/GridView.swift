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
		let randomColor = ColorRandom()
		
		LazyVGrid(columns: [GridItem(.adaptive(minimum: config.size, maximum: 100.0), spacing: config.space)], spacing: config.space, content: {
			ForEach(archive.allSorted.indices, id: \.self) { tweetIndex in
				let tweet = archive.allSorted[tweetIndex]
				
				let hue = randomColor.getHue()
//				let isHovering = hovering?.id == tweet.id
//				let isPinned = pinning.contains(tweet)
				let isHovering = hovered == tweet
				let isPinned = pinned.contains(tweet)
//				ColorPreset.randomHue(luminance: .normal).getColor()
				
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
					.frame(height: config.size)
					.overlay(
						Text("\(tweet.metrics.retweets) \(tweet.metrics.likes)")
							.foregroundColor(popularity > 10 ? .black : .white)
					)
					.overlay(
						isHovering || isPinned ?
							Rectangle()
							.stroke(ColorPreset(hue: hue, lum: .medium, sys: false).getColor(), lineWidth: 4)
							: nil
					)
					.onHover { onHovering in
						if onHovering {
							hovered = tweet
//							interaction.hovered = tweet
						} else {
//							hoveredTweet = nil
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
	}
}
