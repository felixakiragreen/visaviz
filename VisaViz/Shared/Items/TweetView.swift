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
		let hue = tweet.hue ?? .grey
		
		VStack(alignment: .leading, spacing: 8) {
			HStack {
				Text("\(tweet.createdAt, formatter: DateFormatter.bestDateFormatter)")
				Spacer()
				Text("\(tweet.createdAt, formatter: DateFormatter.bestTimeFormatter)")
			}
			.font(.caption)
			.foregroundColor(ColorPreset(hue: hue, lum: .medium).getColor())
			Text("\(tweet.fullText)")
			HStack {
				HStack(spacing: 16) {
					Label {
						Text("\(tweet.metrics.likes)")
					} icon: {
						Image(systemName: "heart.fill")
							.foregroundColor(.secondary)
					}
					Label {
						Text("\(tweet.metrics.retweets)")
					} icon: {
						Image(systemName: "repeat")
							.foregroundColor(.secondary)
					}
				}
				Spacer()
				Link(
					destination: URL(string: "https://twitter.com/i/web/status/\(tweet.id)")!,
					label: {
						Text("open")
						Image(systemName: "square.and.arrow.up")
				})
			}
		}
		.padding()
		.background(
			RoundedRectangle(cornerRadius: 8.0, style: .continuous)
				.fill(
					ColorPreset(hue: .grey, lum: .extraLight).getColor()
				)
		)
		.overlay(
			RoundedRectangle(cornerRadius: 8.0, style: .continuous)
				.strokeBorder(ColorPreset(hue: hue, lum: .extraLight).getColor(), lineWidth: 2, antialiased: true)
		)
//		.clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
	}
}
