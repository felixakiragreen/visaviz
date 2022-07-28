//
//  TweetModel.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/16/21.
//

import Foundation

/**
Should I store whether it's in a thread?
Should I store color here?
*/

struct Tweet: Identifiable, Equatable, Hueable {
	var id: String
	var fullText: String
	var createdAt: Date

	// MARK: - Metrics
	var metrics: Metrics
	struct Metrics: Equatable, Decodable {
		var retweets: Int
		var likes: Int
		
		init(rts: Int = 0, fav: Int = 0) {
			self.retweets = rts
			self.likes = fav
		}
	}
	
	// MARK: - Links
	
	var links: Links
	struct Links: Equatable, Decodable {
		var replyUserName: String?
		var replyUserId: String?
		var replyTweetId: String?
		var threadId: String?
		// TODO:
//		var urls: []
//		var mentions: []
	}
	
	var hue: ColorHue?
}

// MARK: - DECODING
extension Tweet: Decodable {

	enum CodingKeys: String, CodingKey {
		case tweet
		case id
		case createdAt
		case fullText
		case retweetCount
		case favoriteCount
		case inReplyToScreenName
		case inReplyToUserId
		case inReplyToStatusId
		// TODO: urls, mentions
	}
	
	init(fullText: String) {
		self.id = UUID().uuidString
		self.createdAt = Date()
		self.fullText = fullText
		self.metrics = Metrics()
		self.links = Links()
	}

	init(from decoder: Decoder) throws {

		let container = try decoder.container(keyedBy: CodingKeys.self)
		let tweet = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .tweet)

		self.id = try tweet.decode(String.self, forKey: .id)
		self.fullText = try tweet.decode(String.self, forKey: .fullText)
		self.createdAt = try tweet.decode(Date.self, forKey: .createdAt)
		
		let rtCount = Int(try tweet.decode(String.self, forKey: .retweetCount)) ?? 0
		let favCount = Int(try tweet.decode(String.self, forKey: .favoriteCount)) ?? 0
		self.metrics = Metrics(rts: rtCount, fav: favCount)
		
		let replyUserName = try? tweet.decode(String.self, forKey: .inReplyToScreenName)
		let replyUserId = try? tweet.decode(String.self, forKey: .inReplyToUserId)
		let replyTweetId = try? tweet.decode(String.self, forKey: .inReplyToStatusId)
		self.links = Links(replyUserName: replyUserName, replyUserId: replyUserId, replyTweetId: replyTweetId)
	}
}
