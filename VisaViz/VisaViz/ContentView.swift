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
			ControlsView()
				.padding()

			VStack {
				if archive.isLoaded {
					ArchiveLoadedView()
				} else {
					EmptyView()
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)

		} // VStack
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color(.grey, 900))
		.environment(\.colorScheme, .dark)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.embedAtomRoot()
			.preferredColorScheme(.dark)
	}
}

// let pasteboard = NSPasteboard.general
// pasteboard.clearContents()
// pasteboard.setString("string to copy", forType: .string)
