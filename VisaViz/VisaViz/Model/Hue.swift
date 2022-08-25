//
//  Hue.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/25/22.
//

import SwiftUI

enum Hue: String, CaseIterable {
	case grey, blue, green, yellow, orange, red, purple
}

extension Color {
	init(_ hue: Hue, _ level: Int) {
		self.init("\(hue.rawValue).\(level)")
	}
}
