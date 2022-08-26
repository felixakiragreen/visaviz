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

	var body: some View {
		VStack {
			TweetListView()
				.padding()

			GeometryReader { geo in
				ScrollView {
					TweetCanvasView(
						containerWidth: geo.size.width
					)
						.frame(maxWidth: .infinity, minHeight: geo.size.height)
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
		.background(Color(.red, 400).opacity(0.2))
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		AtomRoot {
			ContentView()
				.preferredColorScheme(.dark)
		}
	}
}
