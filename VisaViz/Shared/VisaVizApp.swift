//
//  VisaVizApp.swift
//  Shared
//
//  Created by Felix Akira Green on 1/13/21.
//

import SwiftUI

@main
struct VisaVizApp: App {
	@ObservedObject private var archive = TweetArchive()
	
	var body: some Scene {
		WindowGroup {
			NavigationView {
				ContentView(tweets: $archive.tweets, hoveredTweet: $archive.hoveredTweet)
			}
			.onAppear {
				archive.load()
			}
		}
	}
}
