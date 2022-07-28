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
				archive: TweetArchive.previewData
//				interface: TweetInterface()
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
//	@ObservedObject var interface: TweetInterface
	@ObservedObject private var interface = TweetInterface()
	
	@State var generator = GridGenerator()
	@State var grid: [[Block]] = [[]]
	
//	@Binding var tweets: [Tweet]
//	@Binding var hovering: Tweet?
//	@Binding var pinning: [Tweet]
	
//	@Binding var archive: TweetArchive
//	@EnvironmentObject var archive: TweetArchive

	
	// MARK: - BODY
	var body: some View {
		SideView(
			interface: interface
//			hovering: $hovering,
//			pinning: $pinning
		)
//		.environmentObject(testArchive)
//		.environmentObject(interaction)
		VStack {
			GeometryReader { geometry in
				let size = geometry.size
				
				let cellX: CGFloat = (size.width / CGFloat(grid[0].count))
				let cellY: CGFloat = (size.height / CGFloat(grid.count))
				let cell: CGFloat = min(cellX, cellY)
				let cellPad: CGFloat = cell * 0.1
				let cellSize: CGFloat = cell - cellPad
				
		
				/*
				GridView(
					archive: archive,
//					interaction: $interaction,
//					tweets: $tweets,
					hovered: $interface.hovered,
					pinned: $interface.pinned,
					config: gridViewConfig
				)
				*/
				GeneratedGridView(
					grid: grid,
					hovered: $interface.hovered,
					pinned: $interface.pinned,
					config: GridConfig(size: cellSize, pad: cellPad)
				)
//				.environmentObject(interaction)
//				.environmentObject(testArchive)
				.drawingGroup()
				.onChange(of: size, perform: { newSize in
					if newSize.width.isNormal && newSize.height.isNormal {
						update(size: newSize)
					} else {
						print("WARNING: newSize isNOTnormal")
					}
				})
			}
		}//: MainView
//		.padding()
//		.frame(minWidth: 1000, minHeight: 800)
	}
	
	func update(size: CGSize) {
		generator = GridGenerator()
		
		generator.calculateCounts(cellCount: archive.stats.tweetCount, spaceSize: size)
		
		grid = generator.generate(tweets: archive.allSorted)
	}
}


