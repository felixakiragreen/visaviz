//
//  TweetView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/15/21.
//

import SwiftUI

// MARK: - PREVIEW
struct TweetView_Previews: PreviewProvider {
	static var previews: some View {
		TweetView(tweet: Tweet(fullText: "test tweet"))
	}
}


struct TweetView: View {
	// MARK: - PROPS
	var tweet: Tweet
	
	// MARK: - BODY
	var body: some View {
		VStack {
			Text("\(tweet.createdAt, formatter: DateFormatter.mediumDateTimeFormatter)")
			Text("\(tweet.fullText)")
		}
	}
}
