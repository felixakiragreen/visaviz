//
//  Tweet.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/25/22.
//

import Foundation

struct Tweet: Hashable, Identifiable, Codable {
	var id: String
	var idInt: Int
	var fullText: String
	var createdAt: Date
	
	var favoriteCount: Int
	var retweetCount: Int
	
	var replyUserName: String?
	var replyUserId: String?
	var replyTweetId: String?
	var threadId: String?

	enum CodingKeys: String, CodingKey {
		case tweet
		case id
		case fullText
		case createdAt
		case favoriteCount
		case retweetCount
		case inReplyToScreenName
		case inReplyToUserId
		case inReplyToStatusId
	}

	init(from decoder: Decoder) throws {
		// let container: KeyedDecodingContainer<Tweet.CodingKeys> = try decoder.container(keyedBy: Tweet.CodingKeys.self)

		let container = try decoder.container(keyedBy: CodingKeys.self)
		let tweet = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .tweet)

		/// SHOULD BE WORKING
		// self.id = try tweet.decode(String.self, forKey: .id)
		// self.fullText = try tweet.decode(String.self, forKey: .fullText)
		// self.createdAt = try tweet.decode(Date.self, forKey: .createdAt)

		let tryId = try tweet.decodeIfPresent(String.self, forKey: .id)
		
		id = tryId ?? UUID().uuidString
		idInt = (tryId != nil) ? Int(tryId!) ?? 0 : 0
		fullText = try tweet.decodeIfPresent(String.self, forKey: .fullText) ?? ""
		createdAt = try tweet.decodeIfPresent(Date.self, forKey: .createdAt) ?? Date()
		
		favoriteCount = Int(try tweet.decode(String.self, forKey: .favoriteCount)) ?? 0
		retweetCount = Int(try tweet.decode(String.self, forKey: .retweetCount)) ?? 0
		
		replyUserName = try? tweet.decodeIfPresent(String.self, forKey: .inReplyToScreenName)
		replyUserId = try? tweet.decodeIfPresent(String.self, forKey: .inReplyToUserId)
		replyTweetId = try? tweet.decodeIfPresent(String.self, forKey: .inReplyToStatusId)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(id, forKey: CodingKeys.id)
		try container.encode(fullText, forKey: CodingKeys.fullText)
		try container.encode(createdAt, forKey: CodingKeys.createdAt)
	}
}
