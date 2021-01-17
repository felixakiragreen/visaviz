//
//  SideView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/15/21.
//

import SwiftUI

// MARK: - PREVIEW

struct SideView_Previews: PreviewProvider {
	static var previews: some View {
		SideView(
			interface: TweetInterface()
//			hovering: .constant(nil),
//			pinning: .constant([])
		)
//		.environmentObject(TweetArchive())
//		.environmentObject(TweetInteraction())
	}
}

struct SideView: View {
	// MARK: - PROPS
	
//	@EnvironmentObject var testArchive: TweetArchive
//	@EnvironmentObject var interaction: TweetInteraction

	@ObservedObject var interface: TweetInterface
	
//	@Binding var hovering: Tweet?
//	@Binding var pinning: [Tweet]

	// MARK: - BODY

	var body: some View {
		VStack(spacing: 8) {
			Text("sidebar")
			Divider()

//			Text("Sorting → Date.Asc")
			WIP(label: "sorting selection", vertical: true)
//			Picker(selection: $config.coloring.mode, label: ArrowLabel("mode")) {
//				Text("single").tag(ColorMode.single)
//				Text("main").tag(ColorMode.main)
//				Text("group").tag(ColorMode.group)
//				Text("random").tag(ColorMode.random)
//			}.pickerStyle(SegmentedPickerStyle())
			Divider()
//			Toggle(isOn: $autoSize) {
//				Text("autoSize")
//			}
//			Divider()
			
			Group {

				ForEach(Array(interface.pinned.enumerated()), id: \.offset) { offset, pinnedTweet in
				TweetView(tweet: pinnedTweet)
					// TODO: cleanup
					.onTapGesture {
						interface.pinned.remove(at: offset)
					}
			}

			Spacer()

			if let tweet = interface.hovered {
				TweetView(tweet: tweet)
			}

			Spacer()
				
			}//: Group
			.padding(.horizontal)
		}//: Sidebar
	}
}
