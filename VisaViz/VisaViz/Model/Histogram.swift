//
//  Histogram.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/29/22.
//

import Foundation

class Histogram {
	static let shared = Histogram()

	var lightLevels: Int = 7
	var baseLightLevel: Int {
		(lightLevels + 1) * 100
	}

	// Privated initializer access
	private init() {}
}
