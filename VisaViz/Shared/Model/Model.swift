//
//  Model.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/15/21.
//

import Foundation

struct Tweet: Identifiable, Equatable {
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
//		var urls: []
//		var mentions: []
	}
}

// MARK: - PREVIEW
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


/**
Later on:
first step could be programmatically changing `window.YTD.tweet.part0 = [ {` to `[ {` to make valid JSON

How olybot does it
```
function loadTweets(text, color, archiveName){
	 text = text.slice(text.indexOf("["));
	 data = JSON.parse(text);
	 flattenTweets(data).forEach((tweet) => {
		  let t = new TweetWrapper(tweet, false, color, archiveName);//These tweets are being pulled from the archive, so not foreign
		  loadedTweets[t.tweet.id] = t;
	 });
}
```
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







