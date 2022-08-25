//
//  TweetListView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/25/22.
//

import Atoms
import SwiftUI

struct TweetListView: View {
	
	@WatchStateObject(TweetArchiveAtom())
	var archive
	
	@Watch(TopColorsAtom())
	var topColors
	
	var body: some View {
		VStack {
			HStack {
				Text("tweets: \(archive.allTweets.count)")
				Button("Load") {
					loadFromFile()
				}
				Button("Replies") {
					archive.generateReplies()
					
					// print("replies", archive.replyCount.sorted(by: {
					// 	$0.value > $1.value
					// }))
				}
			}
			HStack {
				HStack(spacing: 4) {
					ForEach(topColors.sorted(by: { $0.value.1 > $1.value.1 }), id: \.value.0) { tc in
						RoundedRectangle(cornerRadius: 4, style: .continuous)
							.foregroundColor(Color(tc.value.0, 400))
							.frame(width: 16, height: 16)
						Text("\(tc.key) (\(tc.value.1))")
					}
				}
			}
			// ForEach(archive.allTweets) { tweet in
			// 	HStack {
			// 		Text("id: \(tweet.id)")
			// 		Text("fullText: \(tweet.fullText)")
			// 	}
			// }
		}
	}
	
	@MainActor
	func loadFromFile() {
		Task {
			await archive.load()
		}
	}
}

struct TweetListView_Previews: PreviewProvider {
	static var previews: some View {
		AtomRoot {
			TweetListView()
				.preferredColorScheme(.dark)
		}
	}
}
