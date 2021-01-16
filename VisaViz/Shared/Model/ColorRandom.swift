//
//  ColorRandom.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/15/21.
//

import SwiftUI
import GameplayKit

class ColorRandom {
	
	var hues: [ColorHue] = [
		.red, .orange, .yellow, .green, .blue, .purple
	]
	
	var seed: Data
	var source: GKRandomSource
	var idCounter: Int = 0
	
	func getIdAndIncrement() -> Int {
		self.idCounter += 1
		return idCounter
	}
	
	init() {
		let seedData = "0".data(using: .utf8)!
		
		self.seed = seedData
		self.source = ColorRandom.makeRandomSource(seed: seedData)
	}
	
	init(seed: String) {
		let seedData = seed.data(using: .utf8)!
		
		self.seed = seedData
		self.source = ColorRandom.makeRandomSource(seed: seedData)
	}
	
	static func makeRandomSource(seed: Data) -> GKRandomSource {
		return GKARC4RandomSource.init(seed: seed)
		
//		return GKMersenneTwisterRandomSource.init(seed: 0)
	}
	
//	GKMersenneTwisterRandomSource
	
	func getColor() -> Color {
		return getColor(with: .medium)
	}
	
	func getColor(with luminance: ColorLuminance) -> Color {
		let hue = getHue()
//		let hue = hues.randomElement(using: source) ?? .grey

		return ColorPreset(hue: hue, lum: luminance).getColor()
	}
	
	func getHue() -> ColorHue {
		let hueIndex = source.nextInt(upperBound: hues.count)
		return hues[hueIndex]
	}
	
	
//	let noise(seed: Data)
	
	
//	extension ColorPreset {
//
//		static func randomHue() ->  {
//			let hue = ColorHue.allCases.randomElement() ?? .grey
//
//			return ColorPreset(hue: hue, lum: luminance)
//		}
//
//	}
}
