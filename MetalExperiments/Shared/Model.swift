//
//  Model.swift
//  MetalExperiments
//
//  Created by Felix Akira Green on 2/11/21.
//

import Foundation

struct Tweet: Identifiable, Equatable {
	var id: String
	var text: String
	var date: Date
	
	// MARK: - Metrics
	var metrics: Metrics
	struct Metrics: Equatable, Decodable {
		var rts: Int
		var fav: Int
		
		init(rts: Int = 0, fav: Int = 0) {
			self.rts = rts
			self.fav = fav
		}
	}
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
		self.date = Date()
		self.text = fullText
		self.metrics = Metrics()
	}
	
	init(from decoder: Decoder) throws {
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let tweet = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .tweet)
		
		self.id = try tweet.decode(String.self, forKey: .id)
		self.text = try tweet.decode(String.self, forKey: .fullText)
		self.date = try tweet.decode(Date.self, forKey: .createdAt)
		
		let rtCount = Int(try tweet.decode(String.self, forKey: .retweetCount)) ?? 0
		let favCount = Int(try tweet.decode(String.self, forKey: .favoriteCount)) ?? 0
		self.metrics = Metrics(rts: rtCount, fav: favCount)
	}
}

