//
//  ContentView.swift
//  Shared
//
//  Created by Felix Akira Green on 1/13/21.
//

import SwiftUI

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ContentView(
				archive: TweetArchive.previewData,
				interaction: TweetInteraction()
//				tweets: .constant(Tweet.previewData),
//				hovering: .constant(nil),
//				pinning: .constant([])
			)
//			.environmentObject(TweetArchive())
//			.environmentObject(TweetInteraction())
		}
	}
}

struct ContentView: View {
	// MARK: - PROPS
	
//	@EnvironmentObject var testArchive: TweetArchive
//	@EnvironmentObject var interaction: TweetInteraction
	
	@ObservedObject var archive: TweetArchive
	@ObservedObject var interaction: TweetInteraction
	
//	@Binding var tweets: [Tweet]
//	@Binding var hovering: Tweet?
//	@Binding var pinning: [Tweet]
	
//	@Binding var archive: TweetArchive
//	@EnvironmentObject var archive: TweetArchive
	
	@State var gridViewConfig = GridView.Config(
		quantity: 100,
		size: 40,
		space: 6
	)
	
//	@State var autoSize: Bool = false

	
	// MARK: - BODY
	var body: some View {
		SideView(
			interaction: interaction
//			hovering: $hovering,
//			pinning: $pinning
		)
//		.environmentObject(testArchive)
//		.environmentObject(interaction)
		VStack {
			GeometryReader { geometry in
				GridView(
					archive: archive,
//					interaction: $interaction,
//					tweets: $tweets,
					hovered: $interaction.hovered,
					pinned: $interaction.pinned,
					config: gridViewConfig
				)
//				.environmentObject(interaction)
//				.environmentObject(testArchive)
				.drawingGroup()
			}
		}//: MainView
//		.padding()
//		.frame(minWidth: 1000, minHeight: 800)
	}
	
///	TODO: calculate
//	func calculateGridSize(size: CGSize) {
//		let ratio = size.width / size.height
//
//
//		repeat {
//
//		} while
//	}
	
}


