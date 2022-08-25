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
	
	enum ArchiveError: Error {
		case fileNotFound
		case invalidString
		case invalidData
		// case decodingFail
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
			
			print("jsonString", jsonString)
			print("jsonData", jsonData)
			
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			
			let dateFormatter = DateFormatter()
			/// Mon Aug 22 18:27:44 +0000 2016
			dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
			decoder.dateDecodingStrategy = .formatted(dateFormatter)
			
			let decodedData = try decoder.decode([Tweet].self, from: jsonData)
			
			allTweets = decodedData
			
		} catch {
			print("error: \(error)")
		}
		
		// if let localData = readLocalFile(forName: "tweet") {
		// 	print(localData)
		// 	if let jsonData = parse(jsonData: localData) {
		// 		/// FOR PERFORMANCE TESTING
		// 		//				populate(allTweets: jsonData.dropLast(350))
		//
		// 		populate(allTweets: jsonData)
		// 	}
		// }
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
}
