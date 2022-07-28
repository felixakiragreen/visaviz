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
	
	@Published var stats: TweetStats = TweetStats()

	struct TweetStats {
		var tweetCount: Int = 0
		var threadCount: Int = 0
	}
	
	init() {}
	
	init(tweets: [Tweet]) {
		populate(allTweets: tweets)
	}
	
	private func populate(allTweets: [Tweet]) {
		print("POPULATING ——————————")
		
//		allSorted = allTweets.sorted { $0.createdAt < $1.createdAt }
		allSorted = allTweets.sorted(by: { (a, b) -> Bool in
			if a.createdAt == b.createdAt {
				// TODO: handle this situation
				// print("exact same timestamp :P")
				return true
			} else {
				return a.createdAt < b.createdAt
			}
		})
		
		generateThreads()
		
		generateColors()
	}
	
	func generateThreads() -> Void {
		// I don't like mutating this way but whatever it works.
		
		/// 1. Go through every tweet
		allSorted.indices.forEach { tweetIndex in
			/// 2. Check if it was in reply to yourself
			if let inReplyTo = allSorted[tweetIndex].links.replyTweetId,
			   let replyToSelfIndex = allSorted.firstIndex(where: { $0.id == inReplyTo })
			{
				/// 3. Update the tweets to show their thread
				/// Check if the tweet replied to has a `threadId`
				if allSorted[replyToSelfIndex].links.threadId == nil {
					/// If NO, then set it to it itself, AND set this tweet's `threadId` to it
					allSorted[replyToSelfIndex].links.threadId = allSorted[replyToSelfIndex].id
					allSorted[tweetIndex].links.threadId = allSorted[replyToSelfIndex].id
				} else {
					/// If YES, set this tweet's `threadId` to the replied to tweet's `threadId`
					allSorted[tweetIndex].links.threadId = allSorted[replyToSelfIndex].links.threadId
				}
				
				guard let threadId = allSorted[tweetIndex].links.threadId else {
					print("FATAL ERROR, threadId wasn't created when it should have been")
					return
				}
				
				/// 4. Update the threads
				/// Check if there is a thread that includes either tweet
				if let threadIndex = threads.firstIndex(where: { $0.id == threadId }) {
					/// If YES, add this tweet to it
					threads[threadIndex].tweets.append(allSorted[tweetIndex])
				} else {
					/// If NO, create it, and add both tweets to it
					threads.append(TweetThread(id: threadId, tweets: [
						allSorted[replyToSelfIndex],
						allSorted[tweetIndex]
					]))
				}
			}
		}
	}

	func generateColors() -> Void {
		let randomColor = ColorRandom()
		
		/// 1. Go through every tweet
		allSorted.indices.forEach { tweetIndex in
			
			/// 2. Check the previous color to prevent duplicates
			var previousHue: ColorHue = .grey
			var newHue: ColorHue = .grey
			if tweetIndex > 0 {
				if let prevHue = allSorted[tweetIndex - 1].hue {
					previousHue = prevHue
				}
				repeat {
					newHue = randomColor.getHue()
				} while newHue == previousHue
			}
			
			/// 3. Check if the tweet belongs to a thread
			if let threadId = allSorted[tweetIndex].links.threadId,
				let threadIndex = threads.firstIndex(where: { $0.id == threadId }) {
				/// If YES, check to see if thread has a hue
				if let threadHue = threads[threadIndex].hue {
					/// If YES, use it
					allSorted[tweetIndex].hue = threadHue
				} else {
					/// If NO, use the new one & update thread
					allSorted[tweetIndex].hue = newHue
					threads[threadIndex].hue = newHue
				}
			} else {
				/// If NO, then use the new one
				allSorted[tweetIndex].hue = newHue
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
			stats.tweetCount = decodedData.count
			print("===================================")
			
			return decodedData
		} catch {
			print("decode error: \(error)")
		}
		
		return nil
	}
}
