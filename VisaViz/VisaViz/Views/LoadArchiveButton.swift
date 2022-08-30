//
//  LoadArchiveButton.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/28/22.
//

import Atoms
import AppKit
import SwiftUI

struct LoadArchiveButton: View {
	
	@WatchStateObject(TweetArchiveAtom())
	var archive
	
	@State private var isLoaderPresented: Bool = false
	
	var body: some View {
		Button(
			action: {
				if !isLoaderPresented {
					isLoaderPresented = true
				}
			},
			label: {
				Text("Open Archive")
			}
		)
		.controlSize(.large)
		.buttonStyle(.borderedProminent)
		.disabled(isLoaderPresented)
		.onChange(of: isLoaderPresented, perform: { presented in
			// binding changed from false to true
			if presented == true {
				let panel = NSOpenPanel()
				panel.allowsMultipleSelection = false
				panel.canChooseDirectories = true
				panel.canChooseFiles = false
				panel.begin { response in
					if response == .OK {
						// print("response", panel.urls)
						loadArchive(url: panel.urls[0])
					}
					// reset the isPresented variable to false
					isLoaderPresented = false
				}
			}
		})
	}
	
	@MainActor
	func loadArchive(url: URL) {
		// print("loadArchive", url)
		Task {
			await archive.loadArchive(path: url)
		}
	}
}

struct LoadArchiveButton_Previews: PreviewProvider {
	static var previews: some View {
		LoadArchiveButton()
	}
}
