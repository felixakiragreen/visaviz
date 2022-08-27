//
//  ContentView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 2022.7.28.
//

import Atoms
import SwiftUI

struct ContentView: View {
	@WatchStateObject(TweetArchiveAtom())
	var archive
	
	@WatchState(ScrollAtom())
	var scroll

	@State var hover: CGPoint?

	var body: some View {
		VStack {
			ControlsView()
				.padding()

			ZStack {
				GeometryReader { geo in
					OffsettableScrollView { point in
						scroll = point.y
					} content: {
						TweetCanvasView(
							size: geo.size
						)
						.frame(maxWidth: .infinity, minHeight: geo.size.height)
					}
				}
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
				
				// Text("scroll \(scroll)")
			}
		}
		.background(Color(.grey, 900))
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.embedAtomRoot()
			.preferredColorScheme(.dark)
	}
}
