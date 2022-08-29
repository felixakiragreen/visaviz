//
//  ArchiveLoadedView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/29/22.
//

import Atoms
import SwiftUI

struct ArchiveLoadedView: View {
	@WatchStateObject(TweetArchiveAtom())
	var archive
	
	@WatchState(ScrollAtom())
	var scroll
	
	@State var hover: CGPoint?
	
	var body: some View {
		ZStack {
			GeometryReader { geo in
				OffsettableScrollView(onOffsetChange: { point in
					scroll = point.y
				}) {
					TweetCanvasView(
						size: geo.size
					)
					.frame(maxWidth: .infinity, minHeight: geo.size.height)
				}
			} // GeometryReader
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			
			.mouseMove(isInside: { inside in
				// print("is inside: \(inside)")
				if inside == false {
					hover = nil
				}
			}, onMove: { location in
				// print("location: \(location)")
				hover = location
			})
			
			if hover != nil {
				TweetHoverView(hover: hover!)
			}
		} // ZStack
	}
}

struct ArchiveLoadedView_Previews: PreviewProvider {
	static var previews: some View {
		ArchiveLoadedView()
			.embedAtomRoot()
			.preferredColorScheme(.dark)
	}
}
