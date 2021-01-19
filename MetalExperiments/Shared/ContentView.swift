//
//  ContentView.swift
//  Shared
//
//  Created by Felix Akira Green on 1/19/21.
//

import struct Forge.ForgeView
import SwiftUI

struct ContentView: View {
	@State var textEntry: String = "initial"
	
	var body: some View {
		ZStack(alignment: .topLeading) {
			SubContentView(text: $textEntry)
			VStack {
				Text("text → \(textEntry)")
				Button("UPDATE") {
					textEntry = "dudeness"
				}
			}
			.padding()
		}
		
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
