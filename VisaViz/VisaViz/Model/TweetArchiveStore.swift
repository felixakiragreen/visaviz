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

	@Published
	var account = Account(
		username: "",
		accountId: "",
		createdAt: Date(),
		accountDisplayName: ""
	)

	@Published var archivePath: URL?
	
	@Published var isLoaded: Bool = false
	var isNotLoaded: Bool {
		!isLoaded
	}
	@Published var anyError: Error?

	enum ArchiveError: Error {
		case fileNotFound
		case invalidString
		case invalidData

		case createURLFailure
		case tweetJSNotFound
		case archivePathNotFound
	}

	private func fileURL(name: String) throws -> URL {
		guard let url = Bundle.main.url(forResource: name, withExtension: "js") else {
			throw ArchiveError.fileNotFound
		}

		return url
	}

	

	func load() async {
		do {
			let fileURL = try fileURL(name: "tweet500")

			await loadFileURL(file: fileURL)
		}
		catch {
			print("error: \(error)")
		}
	}

	// TODO: function for pulling data/tweet.js
	// data/account.js
	// func load

	func loadArchive(path: URL) async {
		archivePath = path
		print("loadArchive", path)

		do {
			// let url = try tweetURL(path: path)
			// print("url...", url.absoluteString)

			// This is not working...
			// let doesFileExist = FileManager.default.fileExists(atPath: url.absoluteString)
			// print("doesFileExist", doesFileExist)

			// await loadFileURL(file: url)
			
			try await loadAccount()
			
			try await loadAllTweets()
			
			isLoaded = true
		}
		catch {
			anyError = error
			print("error: \(error)")
		}
	}

	func loadFileURL(file: URL) async {
		do {
			let (data, _) = try await URLSession.shared.data(from: file)

			let decodedData = try await decodeTweetData(data: data)

			allTweets = decodedData.sorted(by: { $0.createdAt < $1.createdAt })
		}
		catch {
			print("error: \(error)")
		}
	}
	
	//
	// Tweets (data/tweet.js, data/tweet-part1.js, +)
	//
	
	func loadAllTweets() async throws {
		guard let archivePath else {
			throw ArchiveError.archivePathNotFound
		}

		let url = try tweetURL(path: archivePath)
		
		// print("url", url)
	
		try await loadTweets(url: url)
		
		var i = 1
		while let partUrl = tweetPartitionedURL(path: archivePath, part: i), i < 20 {
			// print("partUrl", partUrl)
			do {
				try await loadTweets(url: partUrl)
				i += 1
			} catch {
				break
			}
		}
		
		// sort all at the end
		allTweets = allTweets.sorted(by: { $0.createdAt < $1.createdAt })
	}
	
	func loadTweets(url: URL) async throws {
		// print("loadTweets:", url)

		let (data, _) = try await URLSession.shared.data(from: url)
		let decodedData = try await decodeTweetData(data: data)
		
		allTweets.append(contentsOf: decodedData)
	}
	
	private func tweetURL(path: URL) throws -> URL {
		guard let url = URL(string: "data/tweet.js", relativeTo: path) else {
			throw ArchiveError.createURLFailure
		}
		
		return url
	}
	
	private func tweetPartitionedURL(path: URL, part: Int) throws -> URL {
		guard let url = URL(string: "data/tweet-part\(part).js", relativeTo: path) else {
			throw ArchiveError.createURLFailure
		}
		
		return url
	}
	
	private func tweetPartitionedURL(path: URL, part: Int) -> URL? {
		guard let url = URL(string: "data/tweet-part\(part).js", relativeTo: path) else {
			return nil
		}
		
		return url
	}

	private func decodeTweetData(data: Data) async throws -> [Tweet] {
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
		decoder.dateDecodingStrategy = .formatted(DateFormatter.tweet)

		let decodedData = try decoder.decode([Tweet].self, from: jsonData)

		return decodedData
	}

	//
	// Account (data/account.js)
	//
	
	func loadAccount() async throws {
		guard archivePath != nil else {
			throw ArchiveError.archivePathNotFound
		}
		
		let url = try accountURL(path: archivePath!)
		
		let (data, _) = try await URLSession.shared.data(from: url)
		
		let decodedData = try await decodeAccountData(data: data)
		
		account = decodedData
	}
	
	private func accountURL(path: URL) throws -> URL {
		guard let url = URL(string: "data/account.js", relativeTo: path) else {
			throw ArchiveError.createURLFailure
		}
		
		return url
	}
	
	private func decodeAccountData(data: Data) async throws -> Account {
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
		decoder.dateDecodingStrategy = .formatted(DateFormatter.iso)

		let decodedData = try decoder.decode([Account].self, from: jsonData)

		return decodedData[0]
	}

	
	//
	// visualizations
	//
	
	func generateReplies() {
		/// mutating directly cause the view to be updated 9000+ times
		var _replyCount: [String: Int] = [:]
		for tweetIndex in allTweets.indices {
			if let repliedTo = allTweets[tweetIndex].replyUserName {
				if _replyCount[repliedTo] == nil {
					_replyCount[repliedTo] = 1
				}
				else {
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
		var _histogram: [Int: Int] = [:]

		for tweet in allTweets {
			let lit = tweet.computeLit(max: max)
			if _histogram[lit] == nil {
				_histogram[lit] = 1
			}
			else {
				_histogram[lit]! += 1
			}
		}

		return _histogram
	}
}
