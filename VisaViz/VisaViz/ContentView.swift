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

	@State var hover: CGPoint?

	var body: some View {
		VStack {
			ControlsView()
				.padding()

			ZStack {
				GeometryReader { geo in
					ScrollView {
						TweetCanvasView(
							container: geo.size,
							hover: hover
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
			}
		}
		// .background(Color(.red, 400).opacity(0.2))
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
