//
//  ContentView.swift
//  Shared
//
//  Created by Felix Akira Green on 1/19/21.
//

import SwiftUI
import struct Forge.ForgeView

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}


struct ContentView: View {
	
	// MARK: - PROPS
	
	@EnvironmentObject var renderer: Renderer
//	@State var textEntry: String = "initial"
	
	// MARK: - BODY
	var body: some View {
		ZStack(alignment: .topLeading) {
			ForgeView(renderer: renderer)
				.frame(minWidth: 512, minHeight: 512)
//				.edgesIgnoringSafeArea(.all)
//			SubContentView(text: $textEntry)
//			VStack {
//				Text("text → \(textEntry)")
//				Button("UPDATE") {
//					textEntry = "dudeness"
//				}
//			}
//			.padding()
		}
		
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
	}
}
