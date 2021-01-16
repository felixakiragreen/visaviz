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
			tweets: .constant(Tweet.previewData),
			hovering: .constant(nil),
			pinning: .constant([])
		)
	}
}


struct GridView: View {
	// MARK: - PROPS
	
	@Binding var tweets: [Tweet]
	@Binding var hovering: Tweet?
	@Binding var pinning: [Tweet]
	
	struct Config {
		var quantity: Int = 100
		var size: CGFloat = 10.0
		var space: CGFloat = 2.0
	}
	
	var config = Config()
	
	var randomColor = ColorRandom()
	
	// MARK: - BODY
	var body: some View {
		LazyVGrid(columns: [GridItem(.adaptive(minimum: config.size, maximum: 100.0), spacing: config.space)], spacing: config.space, content: {
			ForEach(tweets.indices, id: \.self) { tweetIndex in
				let tweet = tweets[tweetIndex]
				
				let hue = randomColor.getHue()
				let isHovering = hovering?.id == tweet.id
				let isPinned = pinning.contains(tweet)
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
							hovering = tweet
						} else {
//							hoveredTweet = nil
						}
					}
					.onTapGesture {
						if pinning.contains(tweet) {
							guard let index = pinning.firstIndex(of: tweet) else {
								return
							}
							pinning.remove(at: index)
						} else {
							pinning.append(tweet)
						}
					}
			}
		})
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
		.padding(config.space)
	}
}
