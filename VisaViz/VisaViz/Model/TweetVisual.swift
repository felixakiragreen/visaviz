//
//  TweetVisual.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/25/22.
//

import Foundation

struct TweetVisual: Hashable, Identifiable {
	var id: String
	
	var hue: Hue
	var lit: Int // lightness
	
	// TODO: x & y position
}
