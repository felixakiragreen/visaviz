//
//  Tweet.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/25/22.
//

import Foundation

struct Tweet: Hashable, Identifiable, Codable {
	var id: String
	var fullText: String
	var createdAt: Date

	enum CodingKeys: String, CodingKey {
		case tweet
		case id
		case fullText
		case createdAt
	}

	init(from decoder: Decoder) throws {
		// let container: KeyedDecodingContainer<Tweet.CodingKeys> = try decoder.container(keyedBy: Tweet.CodingKeys.self)

		let container = try decoder.container(keyedBy: CodingKeys.self)
		let tweet = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .tweet)

		/// SHOULD BE WORKING
		// self.id = try tweet.decode(String.self, forKey: .id)
		// self.fullText = try tweet.decode(String.self, forKey: .fullText)
		// self.createdAt = try tweet.decode(Date.self, forKey: .createdAt)

		id = try tweet.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
		fullText = try tweet.decodeIfPresent(String.self, forKey: .fullText) ?? "no full text"
		createdAt = try tweet.decodeIfPresent(Date.self, forKey: .createdAt) ?? Date()
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(id, forKey: CodingKeys.id)
		try container.encode(fullText, forKey: CodingKeys.fullText)
		try container.encode(createdAt, forKey: CodingKeys.createdAt)
	}
}
