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
			hovering: .constant(nil),
			pinning: .constant([])
		)
	}
}

struct SideView: View {
	// MARK: - PROPS

	@Binding var hovering: Tweet?
	@Binding var pinning: [Tweet]

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

			ForEach(Array(pinning.enumerated()), id: \.offset) { offset, pinnedTweet in
				TweetView(tweet: pinnedTweet)
					// TODO: cleanup
					.onTapGesture {
						pinning.remove(at: offset)
					}
			}

			Spacer()

			if let tweet = hovering {
				TweetView(tweet: tweet)
			}

			Spacer()
		} //: Sidebar
	}
}
