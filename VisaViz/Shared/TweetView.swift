//
//  TweetView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/15/21.
//

import SwiftUI

// MARK: - PREVIEW
struct TweetView_Previews: PreviewProvider {
	static var previews: some View {
		TweetView(tweet: Tweet(fullText: "test tweet"))
			.padding()
	}
}


struct TweetView: View {
	// MARK: - PROPS
	var tweet: Tweet
	
	// MARK: - BODY
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text("\(tweet.createdAt, formatter: DateFormatter.bestDateFormatter)")
				Spacer()
				Text("\(tweet.createdAt, formatter: DateFormatter.bestTimeFormatter)")
			}
			.font(.caption)
			.foregroundColor(.secondary)
			Text("\(tweet.fullText)")
		}
		.padding()
		.background(
			RoundedRectangle(cornerRadius: 8.0, style: .continuous)
				.fill(
					ColorPreset(hue: .grey, lum: .extraLight).getColor()
				)
		)
//		.clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
		
	}
}
