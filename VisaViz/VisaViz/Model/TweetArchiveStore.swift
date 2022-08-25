//
//  TweetArchiveStore.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/25/22.
//

import Foundation

@MainActor
class TweetArchiveStore: ObservableObject {

	@Published
	var allTweets: [Tweet] = []
	
	@Published
	var replyCount: [String: Int] = [:]
	
	enum ArchiveError: Error {
		case fileNotFound
		case invalidString
		case invalidData
	}
	
	private static func fileURL(name: String) throws -> URL {
		guard let url = Bundle.main.url(forResource: name, withExtension: "js") else {
			throw ArchiveError.fileNotFound
		}
		
		return url
	}
	
	func load() async {
		
		do {
			let fileURL = try TweetArchiveStore.fileURL(name: "tweet50")
			
			let (data, _) = try await URLSession.shared.data(from: fileURL)
			
			let string = String(decoding: data, as: UTF8.self)
			
			guard let jsonBeginIndex = string.firstIndex(of: "[") else {
				throw ArchiveError.invalidString
			}
			
			let jsonString = String(string[jsonBeginIndex...])
			// let jsonString = string.dropFirst(jsonBeginIndex)
			guard let jsonData = jsonString.data(using: .utf8) else {
				throw ArchiveError.invalidData
			}
			
			// print("jsonString", jsonString)
			// print("jsonData", jsonData)
			
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			
			let dateFormatter = DateFormatter()
			/// Mon Aug 22 18:27:44 +0000 2016
			dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
			decoder.dateDecodingStrategy = .formatted(dateFormatter)
			
			let decodedData = try decoder.decode([Tweet].self, from: jsonData)
			
			allTweets = decodedData.sorted(by: { $0.createdAt < $1.createdAt })
			
		} catch {
			print("error: \(error)")
		}
	}
	
	func generateReplies() {
		for tweetIndex in allTweets.indices {
			if let repliedTo = allTweets[tweetIndex].replyUserName {
				if replyCount[repliedTo] == nil {
					replyCount[repliedTo] = 1
				} else {
					replyCount[repliedTo]! += 1
				}
			}
		}
	}
}
