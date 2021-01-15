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
		GridView(tweets: .constant(Tweet.previewData))
	}
}


struct GridView: View {
	// MARK: - PROPS
	
	@Binding var tweets: [Tweet]
	
	struct Config {
		var quantity: Int = 100
		var size: CGFloat = 10.0
		var space: CGFloat = 2.0
	}
	
	var config = Config()
	
	// MARK: - BODY
	var body: some View {
		LazyVGrid(columns: [GridItem(.adaptive(minimum: config.size, maximum: 100.0), spacing: config.space)], spacing: config.space, content: {
			ForEach(tweets) { tweet in
				Rectangle()
					.foregroundColor(.blue)
					.frame(height: config.size)
//					.overlay(
//						Text("\(tweet.id)")
//					)
			}
		})
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
	}
}
