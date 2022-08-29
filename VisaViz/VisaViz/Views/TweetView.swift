//
//  TweetView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/26/22.
//

import SwiftUI

struct TweetView: View {
	var tweet: Tweet

	var vis: TweetVisual

	var size: CGSize

	var body: some View {
		VStack {
			// let slot = getCellSlot()
			// Text("Hover \(hover.x), \(hover.y)")
			// Text("Slot \(slot.0), \(slot.1)")

			// if let tweetIndex = getTweetIndex(),
			// 	let tweet = archive.allTweets[tweetIndex] {
			// Text("id:\(tweet.id)")
			// 	.font(.caption2)
			Text("\(tweet.fullText)")
				.frame(maxWidth: .infinity, alignment: .leading)

			Spacer()
				.frame(height: 16)

			HStack {
				Text("\(DateFormatter.fullDateTime.string(from: tweet.createdAt))")
					.foregroundColor(Color(.grey, 400))

				Spacer()

				Text("\(Image(systemName: "heart.fill"))")
					.foregroundColor(Color(.red, 400))
				Text("\(tweet.favoriteCount)")
				Text("\(Image(systemName: "arrow.2.squarepath"))")
					.foregroundColor(Color(.blue, 400))
				Text("\(tweet.retweetCount)")
				
				// Text(" {\(vis.lit)}")
			}
		}
		.padding()
		.frame(maxWidth: size.width)
		.background(
			RoundedRectangle(cornerRadius: 16, style: .continuous)
				.fill(.ultraThinMaterial)
				.overlay(
					RoundedRectangle(cornerRadius: 16, style: .continuous)
						.inset(by: -2)
						.strokeBorder(lineWidth: 2)
						.foregroundColor(vis.clr)
				)
		)
	}
}

struct TweetView_Previews: PreviewProvider {
	static var previews: some View {
		TweetView(
			tweet: Tweet(
				id: "1",
				idInt: 1,
				// fullText: "Temporibus fuga molestiae quidem eveniet totam officiis ut animi minima excepturi autem. Ducimus et praesentium officiis quo. Quia fugiat aut possimus eius quidem blanditiis dicta odio repudiandae. Id qui ipsam dolores et quae alias.",
				fullText: "Temporibus fuga molestiae.",
				createdAt: Date(),
				favoriteCount: 20,
				retweetCount: 0
			),
			vis: TweetVisual(id: "1", hue: .blue, lit: 4),
			size: CGSize(width: 300, height: 200)
		)
		.embedAtomRoot()
		.preferredColorScheme(.dark)
	}
}
