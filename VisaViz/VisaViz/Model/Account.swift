//
//  Account.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/29/22.
//

import Foundation

// window.YTD.account.part0 = [ {
// 	"account" : {
// 		"email" : "dubert@me.com",
// 		"createdVia" : "web",
// 		"username" : "impetuous_f_a_g",
// 		"accountId" : "16865488",
// 		"createdAt" : "2008-10-20T11:06:33.000Z",
// 		"accountDisplayName" : "f𝘦𝘭𝘪𝘹 a𝘬𝘪𝘳𝘢 g𝘳𝘦𝘦𝘯"
// 	}
// } ]

struct Account: Hashable, Codable {
	var username: String
	var accountId: String
	var createdAt: Date
	var accountDisplayName: String

	enum CodingKeys: CodingKey {
		case account // for nested data only
		case username
		case accountId
		case createdAt
		case accountDisplayName
	}

	init(
		username: String,
		accountId: String,
		createdAt: Date,
		accountDisplayName: String
	) {
		self.username = username
		self.accountId = accountId
		self.createdAt = createdAt
		self.accountDisplayName = accountDisplayName
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let account = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .account)

		username = try account.decode(String.self, forKey: CodingKeys.username)
		accountId = try account.decode(String.self, forKey: CodingKeys.accountId)
		createdAt = try account.decode(Date.self, forKey: CodingKeys.createdAt)
		accountDisplayName = try account.decode(String.self, forKey: CodingKeys.accountDisplayName)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(username, forKey: CodingKeys.username)
		try container.encode(accountId, forKey: CodingKeys.accountId)
		try container.encode(createdAt, forKey: CodingKeys.createdAt)
		try container.encode(accountDisplayName, forKey: CodingKeys.accountDisplayName)
	}
}
