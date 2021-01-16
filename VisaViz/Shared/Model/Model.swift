//
//  Model.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/15/21.
//

import Foundation

struct Tweet: Identifiable, Equatable, Decodable {
	var id: String
	var fullText: String
	var createdAt: Date

	struct Metrics: Equatable, Decodable {
		var rt: Int
		var fav: Int
		
		init(rt: Int = 0, fav: Int = 0) {
			self.rt = rt
			self.fav = fav
		}
	}
	
	var metrics: Metrics
	

	/*
	 TODO: Entities
	 */

	enum CodingKeys: String, CodingKey {
		case tweet
		case id
		case createdAt
		case fullText
		case retweetCount
		case favoriteCount
	}
	
	init(fullText: String) {
		self.id = UUID().uuidString
		self.createdAt = Date()
		self.fullText = fullText
		self.metrics = Metrics()
	}

	init(from decoder: Decoder) throws {
//		decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase

		let container = try decoder.container(keyedBy: CodingKeys.self)
		let tweet = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .tweet)

//		self = container try container.decode(String.self, forKey: )

		self.id = try tweet.decode(String.self, forKey: .id)
		self.fullText = try tweet.decode(String.self, forKey: .fullText)
		self.createdAt = try tweet.decode(Date.self, forKey: .createdAt)
		
//		guard let idInt = Int(try values.decode(String.self, forKey: .id)) else {
//						fatalError("The id is not an Int")
//				  }
		
//		TODO: add guards here
		let rtCount = Int(try tweet.decode(String.self, forKey: .retweetCount)) ?? 0
		let favCount = Int(try tweet.decode(String.self, forKey: .favoriteCount)) ?? 0
		
		self.metrics = Metrics(rt: rtCount, fav: favCount)
	}
}

extension Tweet {
	static var previewData: [Tweet] {
		[
			Tweet(fullText: "abcde"),
			Tweet(fullText: "abcde"),
			Tweet(fullText: "abcde"),
			Tweet(fullText: "abcde"),
			Tweet(fullText: "abcde")
		]
//		Array.init(repeating: Tweet(fullText: "abcde"), count: 20)
	}
}

// struct Tweets: Decodable {
//	var tweets: [Tweet]
//
//	enum CodingKeys: String, CodingKey {
//		case window
//		case ytd = "YTD"
//		case tweet
//		case part = "part"
////		  case bestFriend = "Best"
////		  case funnyGuy = "FunnyGuy"
////		  case favoriteWeirdo = "FavoriteWeirdo"
//	}
//
//	// Decoding
//	init(from decoder: Decoder) throws {
////		let decoder = JSONDecoder()
//
////		let container = try decoder.container(keyedBy: CodingKeys.self)
//
////		tweets = try decoder.
//
//
////		let step1 = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .window)
////		let step2 = try step1.nestedContainer(keyedBy: CodingKeys.self, forKey: .ytd)
////		let step3 = try step2.nestedContainer(keyedBy: CodingKeys.self, forKey: .tweet)
////		let step4 = try step3.nestedContainer(keyedBy: CodingKeys.self, forKey: .tweet)
////		tweets = try container.decode([Tweet].self, forKey: .tweet)
////			  bar = try response.decode(Bool.self, forKey: .bar)
////			  baz = try response.decode(String.self, forKey: .baz)
////			  let friends = try response.nestedContainer(keyedBy: CodingKeys.self, forKey: .friends)
////			  bestFriend = try friends.decode(String.self, forKey: .bestFriend)
////			  funnyGuy = try friends.decode(String.self, forKey: .funnyGuy)
////			  favoriteWeirdo = try friends.decode(String.self, forKey: .favoriteWeirdo)
//	}
// }

/**

Later on:
first step could be programmatically changing `window.YTD.tweet.part0 = [ {` to `[ {` to make valid JSON

*/

class TweetArchive: ObservableObject {
	@Published var tweets: [Tweet] = []
	@Published var hovering: Tweet?
	@Published var pinning: [Tweet] = []

	init() {}
	
	init(tweets: [Tweet]) {
		self.tweets = tweets
	}
	
	func load() {
		if let localData = readLocalFile(forName: "tweet") {
			print(localData)
			if let jsonData = self.parse(jsonData: localData) {
//				print("error")
//				return
//				let sortedTweets =
				tweets = jsonData.sorted { $0.createdAt < $1.createdAt }
			}
		}
//		DispatchQueue.global(qos: .background).async { [weak self] in
//			guard let data = try? Data(contentsOf: Self.fileURL) else {
//				#if DEBUG
//					DispatchQueue.main.async {
//						self?.daily = DailyAnnotation.testData
//					}
//				#endif
//				return
//			}
//			guard let dailyAnnotations = try? JSONDecoder().decode([DailyAnnotation].self, from: data) else {
//				fatalError("Can't decode saved scrum data.")
//			}
//			DispatchQueue.main.async {
//				self?.daily = dailyAnnotations
//			}
//		}
	}

	private func readLocalFile(forName name: String) -> Data? {
		do {
			if let bundlePath = Bundle.main.path(forResource: name,
			                                     ofType: "json"),
				let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
			{
				return jsonData
			}
		} catch {
			print(error)
		}

		return nil
	}

	private func parse(jsonData: Data) -> [Tweet]? {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
//		dateFormatter.locale = Locale(identifier: "en_US")
//		dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
		decoder.dateDecodingStrategy = .formatted(dateFormatter)


	  //Mon Aug 22 18:27:44 +0000 2016


		do {
//			let decodedData = try decoder.decode(Tweet.self,
//			                                     from: jsonData)

			let decodedData = try decoder.decode([Tweet].self,
			                                     from: jsonData)
//			let container = try decoder.container(keyedBy: CodingKeys.self)

			print("Count: ", decodedData.count)
//			print("Description: ", decodedData.description)
			print("===================================")
			
			return decodedData
			
		} catch {
			print("decode error: \(error)")
		}
		
		return nil
	}
}

extension TweetArchive {

	static var previewData: TweetArchive = TweetArchive(tweets: Tweet.previewData)

}

//
// let decoder = JSONDecoder()
// decoder.keyDecodingStrategy = .convertFromSnakeCase
//
// let blog: Blog = try! decoder.decode(Blog.self, from: jsonData)
// print(blog.numberOfPosts) // Prints: 47093
//
// let decoder = JSONDecoder()
// let dateFormatter = DateFormatter()
// dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
// dateFormatter.locale = Locale(identifier: "en_US")
// dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
// decoder.dateDecodingStrategy = .formatted(dateFormatter)


//Mon Aug 22 18:27:44 +0000 2016
