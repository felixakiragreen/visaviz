//
//  ContentView.swift
//  Shared
//
//  Created by Felix Akira Green on 1/19/21.
//

import SwiftUI
import struct Forge.ForgeView

struct ContentView: View {
	
	let renderer = Renderer()
	
	var body: some View {
//		renderer.setup()
		
		ZStack {
			Text("Asd")
			ForgeView(renderer: renderer)
		}.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
