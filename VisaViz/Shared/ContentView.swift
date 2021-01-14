//
//  ContentView.swift
//  Shared
//
//  Created by Felix Akira Green on 1/13/21.
//

import SwiftUI

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

struct ContentView: View {
	// MARK: - PROPS
	
	@State var gridViewConfig = GridView.Config(
		quantity: 100000,
		size: 4,
		space: 1
	)
	
	@State var show = false
	
	// MARK: - BODY
	var body: some View {
		VStack {
			HStack {
//				Text("testz")
				Button("\(show ? "hide()" :  "show()")") {
					show.toggle()
				}
//				Button("set q to 100") {
//					gridViewConfig.quantity = 100
//				}
//				Button("set q to 1000") {
//					gridViewConfig.quantity = 1000
//				}
			}
			Divider()
			if show {
				GridView(config: gridViewConfig)
					.drawingGroup()
			} else {
				Spacer()
			}
		}
		.frame(minWidth: 1000, minHeight: 800)
	}
}
