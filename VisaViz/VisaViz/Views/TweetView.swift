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

	let tweetTappedPublisher = NotificationCenter.default
		.publisher(for: .TweetTapped)

	@State var showCopyToClipboard = false

	var body: some View {
		VStack {
			Text("\(tweet.fullText)")
				.frame(maxWidth: .infinity, alignment: .leading)

			Spacer()
				.frame(height: 16)

			HStack {
				Text("\(DateFormatter.full.string(from: tweet.createdAt))")
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
		.overlay(
			ZStack {
				if showCopyToClipboard {
					VStack {
						Text("Tweet URL Copied to Clipboard")
					}
					.padding(8)
					.background(
						RoundedRectangle(cornerRadius: 8, style: .continuous)
						.fill(.ultraThinMaterial)
					)
					.offset(x: 0, y: -36)
					.transition(.move(edge: .bottom).combined(with: .opacity))
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
			.animation(.interactiveSpring(), value: showCopyToClipboard)
		)
		.onReceive(tweetTappedPublisher) { notification in
			print("received.TweetTapped", notification)
			if let index = notification.object as? Int {
				print("index of tweet", index)
				showCopyToClipboard = true
				Task {
					try? await Task.sleep(seconds: 2.0)
					showCopyToClipboard = false
				}
			}
		}
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
