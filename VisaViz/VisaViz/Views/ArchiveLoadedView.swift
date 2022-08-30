//
//  ArchiveLoadedView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/29/22.
//

import Atoms
import SwiftUI

extension NSNotification.Name {
	static let TweetTapped = Notification.Name("TweetTappedNotification")
}

struct ArchiveLoadedView: View {
	@WatchStateObject(TweetArchiveAtom())
	var archive

	@WatchState(GridAtom())
	var grid

	@WatchState(ScrollAtom())
	var scroll

	var window: CGSize
	@State var hover: CGPoint?

	let pad: CGFloat = 16
	var pad2: CGFloat {
		pad * 2
	}

	var mouseOver: MouseOver {
		MouseOver(
			window: window,
			grid: grid,
			scroll: scroll,
			hover: hover ?? .zero
		)
	}

	var body: some View {
		ZStack {
			//
			// tracking movement
			//
			Color.clear
				.mouseMove(isInside: { inside in
					if inside == false {
						hover = nil
					}
				}, onMove: { location in
					hover = location
				})
				.padding(.horizontal, pad)
				.padding(.bottom, pad)

			//
			// canvas scroll view
			//
			OffsettableScrollView(onOffsetChange: { point in
				scroll = min(0, point.y)
			}) {
				TweetCanvasView(
					size: CGSize(width: window.width - pad2, height: window.height)
				)
				.padding(.horizontal, pad)
				.padding(.bottom, pad)
				.frame(maxWidth: .infinity, minHeight: window.height - pad)
			} // ScrollView
			.onTapGesture {
				let index = mouseOver.getTweetIndex()

				if index < archive.allTweets.count {
					let tweetId = archive.allTweets[index].id
					let username = archive.account.accountId
					
					NotificationCenter.default.post(name: .TweetTapped, object: index)

					let tweetURL = "https://twitter.com/" + username + "/status/" + tweetId
					let pasteboard = NSPasteboard.general
					pasteboard.clearContents()
					pasteboard.setString(tweetURL, forType: .string)
				}
			}

			//
			// tweet hover view
			//
			if hover != nil {
				TweetHoverView(
					mouseOver: mouseOver
				)
				.padding(.horizontal, pad)
				.padding(.bottom, pad)
			}
		} // ZStack
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

struct ArchiveLoadedView_Previews: PreviewProvider {
	static var previews: some View {
		ArchiveLoadedView(window: .zero)
			.embedAtomRoot()
			.preferredColorScheme(.dark)
	}
}
