//
//  TweetHoverView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/26/22.
//

import Atoms
import SwiftUI

struct TweetHoverView: View {
	@WatchStateObject(TweetArchiveAtom())
	var archive

	@Watch(TweetVisualsAtom())
	var visuals

	var mouseOver: MouseOver

	/// tweet container
	var container = CGSize(width: 300, height: 200)

	var body: some View {
		if let tweetIndex = getTweetIndex() {
			let tweet = archive.allTweets[tweetIndex]
			let vis = visuals[tweetIndex]

			ZStack(alignment: .topLeading) {
				ZStack {
					TweetView(
						tweet: tweet,
						vis: vis,
						size: container
					)
				}
				.frame(size: mouseOver.getQuadrantSize(), alignment: mouseOver.getQuadrantAlignment())
				// .background(.red.opacity(0.2))
				.offset(mouseOver.getQuadrantOffset())
				.background {
					RoundedRectangle(cornerRadius: 4, style: .continuous)
						.foregroundColor(vis.clr)
						.frame(size: 16)
						.position(mouseOver.hover)
						.allowsHitTesting(false)
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
		}
	}

	func getTweetIndex() -> Int? {
		let index = mouseOver.getTweetIndex()

		if index < archive.allTweets.count {
			return index
		}

		return nil
	}
}

struct TweetHoverView_Previews: PreviewProvider {
	static var previews: some View {
		// TweetHoverView(window: .zero, hover: .zero)
		TweetHoverView(mouseOver: MouseOver(
			window: .zero,
			grid: GridParams(),
			scroll: 0,
			hover: .zero
		))
			.embedAtomRoot()
			.preferredColorScheme(.dark)
	}
}
