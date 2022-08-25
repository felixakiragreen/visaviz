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
	
	var body: some View {
		VStack {
			Text("hey")
			Text("tweets: \(archive.allTweets.count)")
		}
		.onAppear {
			appear()
		}
	}
	
	@MainActor
	func appear() {
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
