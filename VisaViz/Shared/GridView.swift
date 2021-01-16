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
			hoveredTweet: .constant(nil)
		)
	}
}


struct GridView: View {
	// MARK: - PROPS
	
	@Binding var tweets: [Tweet]
	@Binding var hoveredTweet: Tweet?
	
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
				let hue = randomColor.getHue()
				let isHovering = hoveredTweet?.id == tweets[tweetIndex].id
//				ColorPreset.randomHue(luminance: .normal).getColor()
				
				let color = ColorPreset(hue: hue, lum: isHovering ? .normal : .semiDark, sys: false).getColor()
				
				Rectangle()
					.foregroundColor(color)
					.frame(height: config.size)
//					.overlay(
//						isHovering ?
//							Text("\(tweets[tweetIndex].id)")
//						: Text("")
//					)
					.onHover { hovering in
						if hovering {
							hoveredTweet = tweets[tweetIndex]
						} else {
//							hoveredTweet = nil
						}
//						tweets[tweetIndex].hovering = hovering
					}
			}
		})
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
	}
}
