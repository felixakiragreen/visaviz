//
//  Interaction.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/16/21.
//

import Foundation

class TweetInteraction: ObservableObject {

	@Published var hovered: Tweet?
	@Published var pinned: [Tweet] = []

	init() {}
	
}
