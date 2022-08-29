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
			let fileURL = try TweetArchiveStore.fileURL(name: "tweet500")
			
			await loadFileURL(file: fileURL)
		} catch {
			print("error: \(error)")
		}
	}
	
	// TODO: function for pulling data/tweet.js
	// data/account.js
	// func load
	
	func loadFileURL(file: URL) async {
		do {
			let (data, _) = try await URLSession.shared.data(from: file)
			
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
		/// mutating directly cause the view to be updated 9000+ times
		var _replyCount: [String: Int] = [:]
		for tweetIndex in allTweets.indices {
			if let repliedTo = allTweets[tweetIndex].replyUserName {
				if _replyCount[repliedTo] == nil {
					_replyCount[repliedTo] = 1
				} else {
					_replyCount[repliedTo]! += 1
				}
			}
		}
		/// doing it this way means it only happens once
		replyCount = _replyCount
	}
	
	func computeMax() -> Int {
		var _max: Int = 0
		for tweet in allTweets {
			let val = tweet.popularity
			if val > _max {
				_max = val
			}
		}
		return _max
	}
	
	func computeHistogram() -> [Int: Int] {
		let max = computeMax()
		var _histogram: [Int:Int] = [:]
		
		for tweet in allTweets {
			let lit = tweet.computeLit(max: max)
			if _histogram[lit] == nil {
				_histogram[lit] = 1
			} else {
				_histogram[lit]! += 1
			}
		}
		
		return _histogram
	}
}
