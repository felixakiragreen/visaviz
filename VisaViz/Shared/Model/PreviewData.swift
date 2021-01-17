//
//  Model+PreviewData.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/16/21.
//

import Foundation

// MARK: - Tweet
extension Tweet {
	static var previewData: [Tweet] {
		[
			Tweet(fullText: "abcde"),
			Tweet(fullText: "fghij"),
			Tweet(fullText: "klmno"),
			Tweet(fullText: "pqrst"),
			Tweet(fullText: "uvwxyz")
		]
	}
}

// MARK: - Archive
extension TweetArchive {
	static var previewData: TweetArchive = TweetArchive(tweets: Tweet.previewData)
}

