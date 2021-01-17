//
//  Model.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/15/21.
//

import Foundation

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
	@Published var allSorted: [Tweet] = []
//	@Published var allLookup = [String: Tweet]()
	@Published var threads: [TweetThread] = []
//	nonthreads

	init() {}
	
	init(tweets: [Tweet]) {
		populate(allTweets: tweets)
	}
	
	private func populate(allTweets: [Tweet]) {
		print("POPULATING ——————————")
		
//		for eachTweet in allTweets {
//			allLookup[eachTweet.id] = eachTweet
//		}
		
		allSorted = allTweets.sorted { $0.createdAt < $1.createdAt }
		
		generateThreads()
	}
	
	func generateThreads() -> Void {
		// I don't like mutating this way but whatever it works.
		
		/// 1. Go through every tweet
		allSorted.indices.forEach { tweetIndex in
			/// 2. Check if it was in reply to yourself
			if let inReplyTo = allSorted[tweetIndex].links.replyTweetId,
			   let replyToSelfIndex = allSorted.firstIndex(where: { $0.id == inReplyTo })
			{
				
				/// 3. Check if the tweet replied to has a `threadId`
				if allSorted[replyToSelfIndex].links.threadId == nil {
					/// If NO, then set it to it itself, AND set this tweet's `threadId` to it
					allSorted[replyToSelfIndex].links.threadId = allSorted[replyToSelfIndex].id
					allSorted[tweetIndex].links.threadId = allSorted[replyToSelfIndex].id
				} else {
					/// If YES, set this tweet's `threadId` to the replied to tweet's `threadId`
					allSorted[tweetIndex].links.threadId = allSorted[replyToSelfIndex].links.threadId
				}
					
				
				/// 3. Check if there is a thread that includes either tweet
//				if let threadIndex = threads.firstIndex(where: { $0.tweets.contains(where: { $0 == allSorted[tweetIndex] }) }) {
//
//				}
				
				/// 4.
//				print("HEY \(replyToSelfIndex)")
//				allSorted[replyToSelfIndex].metrics.likes = 120
//				allSorted[tweetIndex].metrics.retweets = 100
				
				/// 5.  Update the tweets to show their thread
			}
			
		}
	}
}

// MARK: - JSON Loading

extension TweetArchive {
	func load() {
		if let localData = readLocalFile(forName: "tweet") {
			print(localData)
			if let jsonData = parse(jsonData: localData) {
				/// FOR PERFORMANCE TESTING
//				populate(allTweets: jsonData.dropLast(350))
				
				populate(allTweets: jsonData)
			}
		}
		/// Experiments with async loading for performance???
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

		// Mon Aug 22 18:27:44 +0000 2016

		do {
			let decodedData = try decoder.decode([Tweet].self,
			                                     from: jsonData)

			print("Count: ", decodedData.count)
			print("===================================")
			
			return decodedData
		} catch {
			print("decode error: \(error)")
		}
		
		return nil
	}
}
