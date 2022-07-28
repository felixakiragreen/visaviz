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
//	@ObservedObject private var interface = TweetInterface()
//	@StateObject var testArchive = TweetArchive()
//	@StateObject var interaction = TweetInteraction()
	
//	@StateObject var randomColor = ColorRandom()
	
	var body: some Scene {
		WindowGroup {
			NavigationView {
				ContentView(
					archive: archive
					
//					tweets: $archive.tweets,
//					hovering: $archive.hovering,
//					pinning: $archive.pinning
				)
//				.environmentObject(testArchive)
//				.environmentObject(interaction)
//				.environmentObject(randomColor)
			}
			.onAppear {
				archive.load()
//				testArchive.load()
			}
		}
	}
}
