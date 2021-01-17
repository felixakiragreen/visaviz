//
//  ColorPreset.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/15/21.
//

import SwiftUI


// MARK: - ColorPreset

struct ColorPreset: Equatable {
	var hue: ColorHue
	var lum: ColorLuminance
	var sys: Bool = true /// true → color adapts to darkMode (100 → 900)
	
	/// Initialization from components
	init(hue: ColorHue, lum: ColorLuminance) {
		self.hue = hue
		self.lum = lum
	}
	
	init(hue: ColorHue, lum: ColorLuminance, sys: Bool) {
		self.hue = hue
		self.lum = lum
		self.sys = sys
	}
}

extension ColorPreset {

	/// returns "grey.100" or "grey.sys.100"
	func getString() -> String {
		return ColorPreset.toString((hue, lum), sys: sys)
	}
	
	func getColor() -> Color {
		return Color(getString())
	}
	
	static func toString(_ components: (ColorHue, ColorLuminance), sys: Bool = true) -> String {
		let (hue, lum) = components
		if sys {
			return "\(hue).sys.\(lum.rawValue)"
		} else {
			return "\(hue).\(lum.rawValue)"
		}
	}
}

extension ColorPreset {
	func getSecondaryColor() -> Color {
		let string = ColorPreset.toString((hue, lum.secondary), sys: sys)
		return Color(string)
	}
	
	func getTertiaryColor() -> Color {
		let string = ColorPreset.toString((hue, lum.tertiary), sys: sys)
		return Color(string)
	}
	
	func getQuarternaryColor() -> Color {
		let string = ColorPreset.toString((hue, lum.quarternary), sys: sys)
		return Color(string)
	}
}

/// TODO: an extension that lets you pull a "accessible color" - a black or white color for text

// MARK: - ColorHue

enum ColorHue: String, CaseIterable {
	case grey, red, orange, yellow, green, blue, purple
}

extension ColorHue: Identifiable {
	 var id: String { rawValue }
}

// MARK: - ColorLuminance

enum ColorLuminance: Int, CaseIterable {
	case nearWhite = 100
	case extraLight = 200
	case light = 300
	case normal = 400
	case medium = 500
	case semiDark = 600
	case dark = 700
	case extraDark = 800
	case nearBlack = 900
}

extension ColorLuminance: Identifiable {
	 var id: Int { rawValue }
}

extension ColorLuminance {
	var secondary: ColorLuminance {
		switch self {
		case .nearWhite: return .normal
		case .extraLight: return .medium
		case .light: return .semiDark
		case .normal: return .dark
		case .medium: return .extraDark
		case .semiDark: return .light
		case .dark: return .normal
		case .extraDark: return .medium
		case .nearBlack: return .semiDark
		}
	}
	
	var tertiary: ColorLuminance {
		switch self {
		case .nearWhite: return .light
		case .extraLight: return .normal
		case .light: return .medium
		case .normal: return .semiDark
		case .medium: return .dark
		case .semiDark: return .normal
		case .dark: return .medium
		case .extraDark: return .semiDark
		case .nearBlack: return .dark
		}
	}
	
	var quarternary: ColorLuminance {
		switch self {
		case .nearWhite: return .extraLight
		case .extraLight: return .light
		case .light: return .normal
		case .normal: return .medium
		case .medium: return .semiDark
		case .semiDark: return .medium
		case .dark: return .semiDark
		case .extraDark: return .dark
		case .nearBlack: return .extraDark
		}
	}
}

// MARK: - Hueable

protocol Hueable {
	var hue: ColorHue? { get set }
}
