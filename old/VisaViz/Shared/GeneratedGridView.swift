//
//  GeneratedGridView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/17/21.
//

import SwiftUI

// MARK: - PREVIEW
struct GeneratedGridView_Previews: PreviewProvider {
	static var previews: some View {
		GeneratedGridView(
			grid: [[Block(id: 0), Block(id: 1)]],
			hovered: .constant(nil),
			pinned: .constant([])
		)
	}
}

struct GridConfig {
	var size: CGFloat = 10.0
	var pad: CGFloat = 2.0
}

struct GeneratedGridView: View {
	// MARK: - PROPS
	var grid: [[Block]]
	
	@Binding var hovered: Tweet?
	@Binding var pinned: [Tweet]
	
	var config = GridConfig()
	
	// MARK: - BODY
	var body: some View {
		let blocks = gridToRect(grid: grid, size: config.size, pad: config.pad)
		
		ZStack(alignment: .topLeading) {
			ForEach(blocks, id: \.id) { block in
				
//				let isOverTweet = hovered == tweet
//				let isOverThread: Bool = {
//					if let threadId = hovered?.links.threadId,
//						let threadIndex = archive.threads.firstIndex(where: { $0.id == threadId }) {
////						print("hey")
//						return archive.threads[threadIndex].tweets.contains(where: { $0.id == tweet.id })
//					}
//					return false
//				}()
//				let isPinned = pinned.contains(tweet)
				
				BlockView(block: block)
			}
			
		}
		.animation(.spring())
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
	}
}

