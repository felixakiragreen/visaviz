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
//				archive: .constant(TweetArchive.previewData)
				tweets: .constant(Tweet.previewData),
				hovering: .constant(nil),
				pinning: .constant([])
			)
		}
	}
}

struct ContentView: View {
	// MARK: - PROPS
	
	@Binding var tweets: [Tweet]
	@Binding var hovering: Tweet?
	@Binding var pinning: [Tweet]
	
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
			hovering: $hovering,
			pinning: $pinning
		)
		VStack {
			GeometryReader { geometry in
				GridView(
					tweets: $tweets,
					hovering: $hovering,
					pinning: $pinning,
					config: gridViewConfig
				)
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


