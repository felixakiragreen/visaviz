//
//  LoadFileButton.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/28/22.
//

import Atoms
import AppKit
import SwiftUI

struct LoadFileButton: View {
	
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
				Text("Load tweet.js")
			}
		 )
		 .disabled(isLoaderPresented)
		 .onChange(of: isLoaderPresented, perform: { presented in
			 // binding changed from false to true
			 if presented == true {
				 let panel = NSOpenPanel()
				 panel.allowsMultipleSelection = false
				 panel.canChooseDirectories = false
				 panel.canChooseFiles = true
				 panel.begin { response in
					 if response == .OK {
						 // pickedCompletionHandler(panel.urls)
						 print("picked", panel.urls)
						 loadFromFile(url: panel.urls[0])
					 }
					 // reset the isPresented variable to false
					 isLoaderPresented = false
				 }
			 }
		 })
    }
	
	@MainActor
	func loadFromFile(url: URL) {
		Task {
			await archive.loadFileURL(file: url)
		}
	}
}

struct LoadFileButton_Previews: PreviewProvider {
    static var previews: some View {
        LoadFileButton()
    }
}
