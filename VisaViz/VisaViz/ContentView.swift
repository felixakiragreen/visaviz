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
			ScrollView {
				TweetListView()
				TweetCanvasView()
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
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
