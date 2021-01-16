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
			ContentView(
				tweets: .constant(Tweet.previewData),
				hoveredTweet: .constant(nil)
			)
		}
	}
}

struct ContentView: View {
	// MARK: - PROPS
	
	@Binding var tweets: [Tweet]
	@Binding var hoveredTweet: Tweet?
	
	@State var gridViewConfig = GridView.Config(
		quantity: 100,
		size: 36,
		space: 6
	)

	
	// MARK: - BODY
	var body: some View {
		VStack {
			Text("sidebar")
			Divider()
			
			Text("Sorting → Date.Asc")
			WIP(label: "sorting selection", vertical: true)
//			Picker(selection: $config.coloring.mode, label: ArrowLabel("mode")) {
//				Text("single").tag(ColorMode.single)
//				Text("main").tag(ColorMode.main)
//				Text("group").tag(ColorMode.group)
//				Text("random").tag(ColorMode.random)
//			}.pickerStyle(SegmentedPickerStyle())
			
			Spacer()
			
			if let tweet = hoveredTweet  {
				
				Text("\(tweet.createdAt, formatter: DateFormatter.mediumDateTimeFormatter)")
				Text("\(tweet.fullText)")
			}
			
			Spacer()
			
		}//: Sidebar
		VStack {
			GeometryReader { geometry in
//				if show {
					ScrollView {
						GridView(
							tweets: $tweets,
							hoveredTweet: $hoveredTweet,
							config: gridViewConfig
						)
	//					.drawingGroup()
					}
//				} else {
//					Spacer()
//				}
			}
		}//: MainView
//		.padding()
//		.frame(minWidth: 1000, minHeight: 800)
	}
	
}
