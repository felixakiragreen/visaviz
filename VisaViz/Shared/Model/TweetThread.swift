//
//  TweetThread.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/16/21.
//

import Foundation

struct TweetThread: Identifiable, Equatable, Hueable {
	var id: String

	var tweets: [Tweet]
	
	var hue: ColorHue?
}
