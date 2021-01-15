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
		NavigationView {
		ContentView(tweets: .constant(Tweet.previewData))
		}
	}
}

struct ContentView: View {
	// MARK: - PROPS
	
	@Binding var tweets: [Tweet]
	
	@State var gridViewConfig = GridView.Config(
		quantity: 100,
		size: 36,
		space: 6
	)
	
	@State var show = true
	
	// MARK: - BODY
	var body: some View {
		VStack {
			Text("sidebar")
			Divider()
			Button("\(show ? "hide()" :  "show()")") {
				show.toggle()
			}
			
			
			
		}//: Sidebar
		VStack {
			GeometryReader { geometry in
				if show {
					ScrollView {
					GridView(tweets: $tweets, config: gridViewConfig)
	//					.drawingGroup()
					}
				} else {
					Spacer()
				}
			}
		}//: MainView
		.padding()
//		.frame(minWidth: 1000, minHeight: 800)
	}
	
}
